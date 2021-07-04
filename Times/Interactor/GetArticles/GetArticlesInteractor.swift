//
//  GetArticlesInteractor.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

public class GetArticlesInteractor: Interactor, GetArticlesInteractorInterface {
    
    public typealias Completion = (_ articles: [ArticleEntity]) -> Void
    public typealias ArticlesError = (_ error: ErrorEntity) -> Void
    
    //MARK: - Private Properties
    
    private let getArticlesApiSource: GetArticlesApiSourceInterface
    
    //MARK: - Initializers
    
    public required init(getArticlesApiSource: GetArticlesApiSourceInterface) {
        self.getArticlesApiSource = getArticlesApiSource
        super.init()
        self.getArticlesApiSource.assignCallback(self)
    }
    
    //MARK: - Public Methods
    
    public func getArticles(with searchItem: SearchItemEntity, completion: @escaping Completion, error: @escaping ArticlesError) {
        self._getArticles(with: searchItem, completion: completion, error: error)
    }
    
    //MARK: - Private Methods
    
    private func _getArticles(with searchItem: SearchItemEntity, completion: @escaping Completion, error: @escaping ArticlesError) {
        let safeCompletion: Completion = { (articles) in
            self.finish { completion(articles) }
        }
        
        let safeError: ArticlesError = { (apiError) in
            self.finish { error(apiError) }
        }
        
        self.execute { (interactor: GetArticlesInteractor) in
            interactor.getArticlesApiSource.getArticles(with: searchItem, completion: safeCompletion, error: safeError)
        }
    }
    
}
