//
//  PropertyStoringAssociationPolicy.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public enum PropertyStoringAssociationPolicy {
    case strong
    case copy
    case weak
    
    //MARK: - Public Properties
    
    internal var objcPolicy: objc_AssociationPolicy {
        switch self {
        case PropertyStoringAssociationPolicy.strong:
            return objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
        case PropertyStoringAssociationPolicy.copy:
            return objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC
        case PropertyStoringAssociationPolicy.weak:
            return objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN
        }
    }
}
