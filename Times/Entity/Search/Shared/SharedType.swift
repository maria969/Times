//
//  SharedType.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public enum SharedType: CaseIterable {
    case twitter
    case facebook
    
    //MARK: - Public Properties
    
    public var description: String {
        switch self {
        case SharedType.twitter:
            return "Twitter"
        case SharedType.facebook:
            return "Facebook"
        }
    }
}
