//
//  ErrorEntity.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class ErrorEntity: Error, ApiMappable {
    
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
        
        public init(apiModel: ErrorApiModel.Code) {
            self = ErrorEntity.Code(rawValue: apiModel.rawValue) ?? Code.unknown
        }
    }
    
    //MARK: - Public Properties
    
    public let code: Code
    public let error: ErrorMessageEntity
    
    //MARK: - Initializers
    
    public required init(apiModel: ErrorApiModel) {
        self.code = Code.unknown
        self.error = ErrorMessageEntity(apiModel: apiModel.error)
    }
    
    public required convenience init?(optionalApiModel: ErrorApiModel?) {
        guard let apiModel: ErrorApiModel = optionalApiModel else { return nil }
        self.init(apiModel: apiModel)
    }
}
