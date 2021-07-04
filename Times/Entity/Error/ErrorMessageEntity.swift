//
//  ErrorMessageEntity.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class ErrorMessageEntity: ApiMappable {
    
    //MARK: - Public Properties
    
    public let message: String
    
    //MARK: - Initializers
    
    public required init(apiModel: ErrorMessageApiModel) {
        self.message = apiModel.message
    }
    
    public required convenience init?(optionalApiModel: ErrorMessageApiModel?) {
        guard let apiModel: ErrorMessageApiModel = optionalApiModel else { return nil }
        self.init(apiModel: apiModel)
    }
}
