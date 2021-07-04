//
//  Dictionary+Extension.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public extension Dictionary where Key: Hashable, Value: Any {
    
    //MARK: - Public Methods
    
    mutating func add(items: Dictionary) {
        for (key, value) in items {
            self.updateValue(value, forKey: key)
        }
    }
}
