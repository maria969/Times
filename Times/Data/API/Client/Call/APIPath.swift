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
    enum Articles: APIPathConvertible {
        case mostviewed(String)
        case mostshared(String, String)
        case mostmailed(String)
        
        //MARK: - Public Properties
        
        public var path: String {
            switch self {
            case Articles.mostviewed(let time):
                let viewedPath: String = "viewed"
                return "\(viewedPath)/\(time).json"
            case Articles.mostshared(let time, let shared):
                let sharedPath: String = "shared"
                return "\(sharedPath)/\(time)/\(shared).json"
            case Articles.mostmailed(let time):
                let emailedPath: String = "emailed"
                return "\(emailedPath)/\(time).json"
            }
        }
    }
}
