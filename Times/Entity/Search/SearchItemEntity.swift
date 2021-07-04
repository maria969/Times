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
    
    //MARK: - Public Methods
    
    public func generateItems() -> [SearchSectionUiModel] {
        var items: [SearchSectionUiModel] = []
        
        let searchSection: SearchSectionUiModel = SearchSectionUiModel(id: .searchType, title: "times.search.view.search_type.title".localized())
        for searchType in SearchType.allCases {
            searchSection.items.append(SearchItemUiModel(id: searchType, title: searchType.description, isSelected: (searchType==self.type)))
        }
        items.append(searchSection)
        
        if self.type == SearchType.mostshared{
            let sharedSection: SearchSectionUiModel = SearchSectionUiModel(id: .shared, title: "times.search.view.shared_type.title".localized())
            
            for sharedType in SharedType.allCases {
                sharedSection.items.append(SearchItemUiModel(id: sharedType, title: sharedType.description, isSelected: self.sharedType.contains(sharedType)))
            }
            
            items.append(sharedSection)
        }
        
        let periodSection: SearchSectionUiModel = SearchSectionUiModel(id: .period, title: "times.search.view.time_frame.title".localized())
        
        for period in PeriodType.allCases {
            periodSection.items.append(SearchItemUiModel(id: period, title: period.description, isSelected: (period==self.periodTimeType)))
        }
        
        items.append(periodSection)
        
        return items
    }
    
    public func updateItems(item: SearchItemUiModel) -> [SearchSectionUiModel] {
        if let searchType: SearchType = item.id as? SearchType {
            self.type = searchType
            if searchType != SearchType.mostshared { self.sharedType = [] }
        }
        if let sharedType: SharedType = item.id as? SharedType {
            if self.sharedType.contains(sharedType){
                if let index = self.sharedType.firstIndex(of: sharedType) {
                    self.sharedType.remove(at: index)
                }
            }
            else {
                self.sharedType.append(sharedType)
            }
        }
        if let periodType: PeriodType = item.id as? PeriodType {
            self.periodTimeType = periodType
        }
        
        return self.generateItems()
    }    
}

