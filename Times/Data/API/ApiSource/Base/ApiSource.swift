//
//  ApiSource.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

//MARK: - ApiSourceInput

public class ApiSource: ApiSourceInterface {
    
    //MARK: - Public Methods
    
    public private(set) var queue: DispatchQueue = DispatchQueue.main
    
    //MARK: - Private Properties
    
    private var apiRequester: ApiRequesterInterface
    
    //MARK: - Initilizers
    
    public required init(client: ApiRequesterInterface) {
        self.apiRequester = client
    }
    
    //MARK: - Public Methods
    
    public func assignCallback(_ callback: Queueable) {
        self.queue = callback.workingQueue
    }
    
    //MARK: - Internal Methods
    
    func request(_ endpoint: EndPoint<Void>,
                          response: @escaping ApiClient.Response<Void>,
                          error: @escaping ApiClient.ResponseError) {
        self.apiRequester.request(endpoint, response: response, errorResponse: error)
    }
    
    func request<T: Decodable>(_ endpoint: EndPoint<T>,
                                        response: @escaping ApiClient.Response<T>,
                                        error: @escaping ApiClient.ResponseError) {
        self.apiRequester.request(endpoint, response: response, errorResponse: error)
    }
    
    func request(_ endpoint: EndPoint<Data>,
                          response: @escaping ApiClient.Response<Data>,
                          error: @escaping ApiClient.ResponseError) {
        self.apiRequester.request(endpoint, response: response, errorResponse: error)
    }
}
