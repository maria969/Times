//
//  ErrorApiAdapter.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class ErrorApiAdapter {
    
    //MARK: - Public Methods
    
    public class func adapt(responseError: DataApiResponse) -> ErrorApiModel {
        switch responseError.statusCode {
        case 400...499:
            return self.parseError(errorData: responseError.body, statusCode: responseError.statusCode)
        default:
            return self.defaultError(for: responseError)
        }
    }
    
    //MARK: - Private Methods
    
    private class func parseError(errorData: Data?, statusCode: Int) -> ErrorApiModel {
        let code: ErrorApiModel.Code = ErrorApiModel.Code(code: statusCode)
        guard let errorApi: ErrorApiModel = APIDecoder.decode(ErrorApiModel.self, fromData: errorData) else {
            return ErrorApiModel(code: code, message: ErrorMessageApiModel.default)
        }
        errorApi.code = code
        return errorApi
    }
    
    private class func defaultError(for response: DataApiResponse) -> ErrorApiModel {
        let type: ErrorApiModel.Code = ErrorApiModel.Code(code: response.statusCode)
        switch type {
        case ErrorApiModel.Code.noConnection:
            return ErrorApiModel.noConection
        default:
            return ErrorApiModel(code: type, message: ErrorMessageApiModel.default)
        }
    }
}
