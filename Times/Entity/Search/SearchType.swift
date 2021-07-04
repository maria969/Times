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
            return "times.search_type.mostmailed.description".localized()
        case SearchType.mostshared:
            return "times.search_type.mostshared.description".localized()
        case SearchType.mostviewed:
            return "times.search_type.mostviewed.description".localized()
        }
    }
}
