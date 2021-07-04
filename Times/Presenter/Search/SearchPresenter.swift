//
//  SearchPresenter.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

//MARK: - SearchPresenterInterface

class SearchPresenter: Presenter<SearchViewController>, SearchPresenterInterface {
    
    public typealias Completion = (_ articles: [ArticleEntity]) -> Void
    
    //MARK: - Private Properties
    
    private let getArticlesInteractor: GetArticlesInteractorInterface
    
    //MARK: - Initializers
    
    public required init(getArticlesInteractor: GetArticlesInteractorInterface) {
        self.getArticlesInteractor = getArticlesInteractor
        super.init()
        getArticlesInteractor.assignCallback(self)
    }
    
    //MARK: - Public Methods
    
    public func searchNews(with searchItem: SearchItemEntity, completion: @escaping SearchPresenter.Completion) {
        self.getArticlesInteractor.getArticles(with: searchItem, completion: completion) { (error) in
            self.view?.showError(error, completion: nil)
        }
    }
}
