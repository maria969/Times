//
//  String+Extension.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public extension String {
    
    //MARK: - Public Methods
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
