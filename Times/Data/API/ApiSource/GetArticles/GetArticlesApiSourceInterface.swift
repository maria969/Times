//
//  GetArticlesApiSourceInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

public protocol GetArticlesApiSourceInterface: ApiSourceInterface {
    func getArticles(with searchItem: SearchItemEntity, completion: @escaping GetArticlesApiSource.Completion, error: @escaping GetArticlesApiSource.ArticlesError)
}
