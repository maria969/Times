//
//  ErrorMessageApiModel.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class ErrorMessageApiModel: Decodable {
    
    public static var `default`: ErrorMessageApiModel {
        return ErrorMessageApiModel(message: "times.error.server.general".localized())
    }
    
    public static var noConnection: ErrorMessageApiModel {
        return ErrorMessageApiModel(message: "times.error.server.no_connection".localized())
    }
    
    //MARK: - Public Properties
    
    public var message: String

    //MARK: - CodingKeys
    
    public enum ErrorMessageApiModelCodingKeys: String, CodingKey {
        case message = "faultstring"
    }
    
    //MARK: - Initializers
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ErrorMessageApiModelCodingKeys.self)
        if let message: String = try values.decodeIfPresent(String.self, forKey: .message) {
            self.message = message
        }
        else {
            self.message = ErrorMessageApiModel.default.message
        }
    }
    
    public required init(message: String) {
        self.message = message
    }
}
