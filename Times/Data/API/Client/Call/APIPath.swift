//
//  APIPath.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public enum APIPath {
    case call(APIPathConvertible)
    case customCall(String)
    
    //MARK: - Public Properties
    
    public var path: String {
        switch self {
        case APIPath.call(let apiPath):
            return apiPath.path
        case APIPath.customCall(let path):
            return path
        }
    }
}

//MARK: - Paths

public extension APIPath {
    
}
