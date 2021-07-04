//
//  SearchItemEntity.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class SearchItemEntity {
    public var type: SearchType
    public var sharedType: [SharedType]
    public var periodTimeType: PeriodType
    
    //MARK: - Initializers
    
    public init() {
        self.type = .mostmailed
        self.sharedType = []
        self.periodTimeType = .oneDay
    }
}

