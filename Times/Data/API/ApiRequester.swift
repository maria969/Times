//
//  ApiRequester.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Alamofire

public final class ApiRequester: ApiRequesterInterface {
    
    //MARK: - Private Properties
    
    private let client: ApiClient
    
    //MARK: - Initializers
    
    required init(environment: EnvironmentManagerInterface) {
        self.client = ApiClient(environment: environment,
                                queue: DispatchQueue(label: "com.mariaherrerovaras.times.ApiRequester"))
    }
    
    public func request(_ endpoint: EndPoint<Void>, response: @escaping ApiClient.Response<Void>, errorResponse: @escaping ApiClient.ResponseError) {
        self.client.perform(request: endpoint, response: response, errorResponse: errorResponse)
    }
    
    public func request<T>(_ endpoint: EndPoint<T>, response: @escaping ApiClient.Response<T>, errorResponse: @escaping ApiClient.ResponseError) where T : Decodable {
        self.client.perform(request: endpoint, response: response, errorResponse: errorResponse)
    }
    
    public func request(_ endpoint: EndPoint<Data>, response: @escaping ApiClient.Response<Data>, errorResponse: @escaping ApiClient.ResponseError) {
        self.client.perform(request: endpoint, response: response, errorResponse: errorResponse)
    }
}
