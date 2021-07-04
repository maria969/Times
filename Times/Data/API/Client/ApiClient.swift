//
//  ApiClient.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Alamofire

public final class ApiClient {
    
    public typealias Response<T> = (_ response: T) -> Void
    public typealias ResponseError = (_ error: ErrorApiModel) -> Void
    
    //MARK: - Public Properties
    
    public let environmentManager: EnvironmentManagerInterface
    public let queue: DispatchQueue
    
    public lazy var sessionManager: Session = {
        let environment: EnvironmentInterface = self.environmentManager.environment()
        let configuration: URLSessionConfiguration = URLSessionConfiguration.sessionConfiguration
        configuration.timeoutIntervalForRequest = environment.timeout()
        
        let sessionDelegate: SessionDelegate = SessionDelegate()
        let trustManager: ApiTrustManager = ApiTrustManager()
        
        return Session(configuration: configuration, delegate: sessionDelegate, serverTrustManager: trustManager)
    }()
    
    //MARK: - Initializers
    
    public required init(environment: EnvironmentManagerInterface, queue: DispatchQueue) {
        self.environmentManager = environment
        self.queue = queue
    }
    
    //MARK: - Public Methods
    
    func perform(request endpoint: EndPoint<Void>, response: @escaping ApiClient.Response<Void>, errorResponse: @escaping ApiClient.ResponseError) {
        let apiRequest = endpoint.request(withSession: self.sessionManager)
        self.performRequest(apiRequest, queue: endpoint.queue, success: response, error: errorResponse)
    }
    
    func perform<T: Decodable>(request endpoint: EndPoint<T>, response: @escaping ApiClient.Response<T>, errorResponse: @escaping ApiClient.ResponseError) {
        let apiRequest = endpoint.request(withSession: self.sessionManager)
        let type: T.Type = endpoint.resultType
        self.performDecodableRequest(apiRequest, type: type, queue: endpoint.queue, success: response, error: errorResponse)
    }
    
    func perform(request endpoint: EndPoint<Data>, response: @escaping ApiClient.Response<Data>, errorResponse: @escaping ApiClient.ResponseError) {
        let apiRequest = endpoint.request(withSession: self.sessionManager)
        self.performDataRequest(apiRequest, queue: endpoint.queue, success: response, error: errorResponse)
    }
    
    //MARK: - Execute Methods
    
    private func performRequest(_ request: DataRequest, queue: DispatchQueue, success: @escaping ApiClient.Response<Void>, error: @escaping ApiClient.ResponseError) {
        let validateRequest = request.validate()
        validateRequest.responseData(queue: self.queue) { (dataResponse) in
            self.validateResponse(dataResponse, queue: queue, success: success, error: error)
        }
    }
    
    private func performDataRequest(_ request: DataRequest, queue: DispatchQueue, success: @escaping ApiClient.Response<Data>, error: @escaping ApiClient.ResponseError) {
        let validateRequest = request.validate()
        validateRequest.responseData(queue: self.queue) { (dataResponse) in
            self.validateDataResponse(dataResponse, queue: queue, success: success, error: error)
        }
    }
    
    private func performDecodableRequest<T: Decodable>(_ request: DataRequest, type: T.Type, queue: DispatchQueue, success: @escaping ApiClient.Response<T>, error: @escaping ApiClient.ResponseError) {
        let validateRequest = request.validate()
        validateRequest.responseData(queue: self.queue) { (dataResponse) in
            self.validateDecodableResponse(dataResponse, type: type, queue: queue, success: success, error: error)
        }
    }
    
    //MARK: - Response Methods
    
    private func validateResponse(_ response: AFDataResponse<Data>, queue: DispatchQueue, success: @escaping ApiClient.Response<Void>, error: @escaping ApiClient.ResponseError) {
        switch response.result {
        case Result.success:
            queue.async { success(()) }
        case Result.failure(let responseError):
            let dataApiResponse: DataApiResponse = DataApiResponse(response: response.response, body: response.data, error: responseError)
            self.dispatchError(fromResponse: dataApiResponse, withQueue: queue, andCompletion: error)
        }
    }
    
    private func validateDataResponse(_ response: AFDataResponse<Data>, queue: DispatchQueue, success: @escaping ApiClient.Response<Data>, error: @escaping ApiClient.ResponseError) {
        let dataApiResponse: DataApiResponse = DataApiResponse(response: response.response, body: response.data, error: response.error)
        
        switch response.result {
        case Result.success:
            self.validateData(dataApiResponse.body, queue: queue, success: success, error: error)
        case Result.failure:
            self.dispatchError(fromResponse: dataApiResponse, withQueue: queue, andCompletion: error)
        }
    }
    
    private func validateDecodableResponse<T: Decodable>(_ response: AFDataResponse<Data>, type: T.Type, queue: DispatchQueue, success: @escaping ApiClient.Response<T>, error: @escaping ApiClient.ResponseError) {
        let dataApiResponse: DataApiResponse = DataApiResponse(response: response.response, body: response.data, error: response.error)
        
        switch response.result {
        case Result.success:
            guard let result: T = APIDecoder.decode(type, from: dataApiResponse) else {
                self.dispatchError(fromResponse: dataApiResponse, withQueue: queue, andCompletion: error)
                return
            }
            queue.async { success(result) }
        case Result.failure:
            self.dispatchError(fromResponse: dataApiResponse, withQueue: queue, andCompletion: error)
        }
    }
    
    private func validateData(_ response: Data?, queue: DispatchQueue, success: @escaping ApiClient.Response<Data>, error: @escaping ApiClient.ResponseError) {
        guard let data: Data = response else {
            queue.async { error(ErrorApiModel.default) }
            return
        }
        queue.async { success(data) }
    }
    
    private func dispatchError(fromResponse response: DataApiResponse, withQueue queue: DispatchQueue, andCompletion completion: @escaping ApiClient.ResponseError) {
        let apiError: ErrorApiModel = ErrorApiAdapter.adapt(responseError: response)
        queue.async { completion(apiError) }
    }
}

//MARK: - URLSessionConfiguration

private extension URLSessionConfiguration {
    
    //MARK: - Public Properties
    
    static var sessionConfiguration: URLSessionConfiguration {
        return URLSessionConfiguration.default
    }
}
