//
//  DataApiResponse.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Alamofire

public final class DataApiResponse {
    
    //MARK: - Public Properties
    
    public let statusCode: Int
    public let header: [String: String]
    public let body: Data?
    
    //MARK: - Initializers
    
    required init(statusCode: Int, header: [String: String], body: Data?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }
    
    convenience init(response: HTTPURLResponse?, body: Data?, error: AFError?) {
        if let httpResponse: HTTPURLResponse = response {
            let rawHeader = httpResponse.allHeaderFields
            var header: [String: String] = [:]
            for (key, value) in rawHeader {
                guard let keyString: String = key as? String else { continue }
                guard let headerValue: String = value as? String else { continue }
                header[keyString] = headerValue
            }
            self.init(statusCode: httpResponse.statusCode, header: header, body: body)
        }
        else {
            let code: Int = DataApiResponse.statusCode(for: error)
            self.init(statusCode: code, header: [:], body: body)
        }
    }
    
    //MARK: - Private Methods
    
    private class func statusCode(for error: AFError?) -> Int {
        guard let apiError: AFError = error else { return 500 }
        switch true {
        case apiError.isServerTrustEvaluationError: return 401
        case apiError.isExplicitlyCancelledError: return -999
        default: return self.statusCode(forNetwork: apiError.underlyingError)
        }
    }
    
    private class func statusCode(forNetwork error: Error?) -> Int {
        guard let apiError: Error = error else { return 500 }
        switch apiError._code {
        case URLError.Code.notConnectedToInternet.rawValue,
             URLError.Code.networkConnectionLost.rawValue: return -1009
        case URLError.Code.timedOut.rawValue: return -1001
        default: return 500
        }
    }
}
