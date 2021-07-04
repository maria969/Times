//
//  PeriodType.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public enum PeriodType: CaseIterable {
    case oneDay
    case weak
    case month
    
    //MARK: - Public Properties
    
    public var description: String {
        switch self {
        case PeriodType.oneDay:
            return "1 día"
        case PeriodType.weak:
            return "7 días"
        case PeriodType.month:
            return "30 días"
        }
    }
}
