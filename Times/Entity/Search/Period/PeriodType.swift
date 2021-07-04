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
            return "times.period.one_day.description".localized()
        case PeriodType.weak:
            return "times.period.weak.description".localized()
        case PeriodType.month:
            return "times.period.month.description".localized()
        }
    }
    
    public var apiString: String {
        switch self {
        case PeriodType.oneDay:
            return "1"
        case PeriodType.weak:
            return "7"
        case PeriodType.month:
            return "30"
        }
    }
}
