//
//  SearchType.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public enum SearchType: CaseIterable {
    case mostmailed
    case mostshared
    case mostviewed
    
    //MARK: - Public Properties
    
    public var description: String {
        switch self {
        case SearchType.mostmailed:
            return "Más enviado"
        case SearchType.mostshared:
            return "Más compartido"
        case SearchType.mostviewed:
            return "Más visto"
        }
    }
}
