//
//  GetArticlesInteractorInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

public protocol GetArticlesInteractorInterface: InteractorInterface {
    func getArticles(with searchItem: SearchItemEntity, completion: @escaping GetArticlesInteractor.Completion, error: @escaping GetArticlesInteractor.ArticlesError)
}

