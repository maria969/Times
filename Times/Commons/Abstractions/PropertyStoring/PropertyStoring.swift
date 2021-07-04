//
//  PropertyStoring.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public protocol PropertyStoring {
    func getAssociatedObject<T>(_ key: UnsafeRawPointer!, defaultValue: T) -> T
    func getAssociatedObject<T>(_ key: UnsafeRawPointer!) -> T?
    func setAssociatedObject<T>(_ object: T, for key: UnsafeRawPointer!, policy: PropertyStoringAssociationPolicy)
}

extension PropertyStoring {
    public func getAssociatedObject<T>(_ key: UnsafeRawPointer!) -> T? {
        guard let value: T = objc_getAssociatedObject(self, key) as? T else { return nil }
        return value
    }
    
    public func getAssociatedObject<T>(_ key: UnsafeRawPointer!, defaultValue: T) -> T {
        guard let value: T = objc_getAssociatedObject(self, key) as? T else { return defaultValue }
        return value
    }
    
    public func setAssociatedObject<T>(_ object: T, for key: UnsafeRawPointer!, policy: PropertyStoringAssociationPolicy) {
        objc_setAssociatedObject(self, key, object, policy.objcPolicy)
    }
}
