//
//  ApiRequesterInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public protocol ApiRequesterInterface: AnyObject {
    func request(_ endpoint: EndPoint<Void>, response: @escaping ApiClient.Response<Void>, errorResponse: @escaping ApiClient.ResponseError)
    func request<T: Decodable>(_ endpoint: EndPoint<T>, response: @escaping ApiClient.Response<T>, errorResponse: @escaping ApiClient.ResponseError)
    func request(_ endpoint: EndPoint<Data>, response: @escaping ApiClient.Response<Data>, errorResponse: @escaping ApiClient.ResponseError)
}
