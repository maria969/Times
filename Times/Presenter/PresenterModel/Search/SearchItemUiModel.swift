//
//  SearchItemUiModel.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class SearchItemUiModel {
    public var id: Any
    public var title: String
    public var isSelected: Bool
    
    //MARK: - Initializers
    
    init(id: Any, title: String, isSelected: Bool) {
        self.id = id
        self.title = title
        self.isSelected = isSelected
    }
}
