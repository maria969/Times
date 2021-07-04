//
//  Array+Extension.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public extension Array {
    
    //MARK: - Public Methods
    
    func object(atIndex index: Int) -> Element? {
        guard index >= 0, index < self.count else { return nil }
        return self[index]
    }
}
