//
//  ErrorApiModel.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class ErrorApiModel: Decodable {
    
    public enum Code: Int {
        case badRequest
        case unauthorized
        case internalError
        case forbidden
        case timeOut
        case cancelled
        case noConnection
        case unknown
        
        //MARK: - Initializers
        
        public init(code: Int) {
            switch code {
            case 400:   self = Code.badRequest
            case 401:   self = Code.unauthorized
            case 403:   self = Code.forbidden
            case 500:   self = Code.forbidden
            case -999:  self = Code.cancelled
            case -1001: self = Code.timeOut
            case -1009: self = Code.noConnection
            default:    self = Code.unknown
            }
        }
    }
    
    //MARK: - Public Properties
    
    public var code: Code
    public let error: ErrorMessageApiModel
    
    public static var `default`: ErrorApiModel {
        return ErrorApiModel(code: Code.badRequest, message: ErrorMessageApiModel.default)
    }
    
    public static var noConection: ErrorApiModel {
        return ErrorApiModel(code: Code.noConnection, message: ErrorMessageApiModel.default)
    }

    //MARK: - CodingKeys
    
    public enum ErrorApiModelCodingKeys: String, CodingKey {
        case error = "fault"
    }
    
    //MARK: - Initializers
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ErrorApiModelCodingKeys.self)
        self.code = Code.unknown
        self.error = try values.decodeIfPresent(ErrorMessageApiModel.self, forKey: .error) ?? ErrorMessageApiModel.default
    }
    
    public required init(code: Code, message: ErrorMessageApiModel) {
        self.code = code
        self.error = message
    }
}
