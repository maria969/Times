//
//  SearchSectionUiModel.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class SearchSectionUiModel {
    
    //MARK: - Public Properties
    
    public let id: SearchSectionItemUiModel
    public let title: String
    public var items: [SearchItemUiModel]
    
    //MARK: - Initializers
    
    required init(id: SearchSectionItemUiModel, title: String) {
        self.id = id
        self.title = title
        self.items = []
    }
}
