//
//  GetArticlesApiSource.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

public class GetArticlesApiSource: ApiSource, GetArticlesApiSourceInterface {
    
    public typealias Completion = (_ articles: [ArticleEntity]) -> Void
    public typealias ArticlesError = (_ error: ErrorEntity) -> Void
    
    //MARK: - Public Methods
    
    public func getArticles(with searchItem: SearchItemEntity, completion: @escaping GetArticlesApiSource.Completion, error: @escaping GetArticlesApiSource.ArticlesError){
        
        let path: String = self.getPath(with: searchItem)
        
        let endpoint: EndPoint<ResponseResult<[ArticleApiModel]>> = EndPoint.Builder()
            .method(.get)
            .path(path)
            .parameters(["api-key":"2bB0BGGe2pysadVQorASzqyClBzI5w1G"])
            .queue(self.queue)
            .build()
        
        self.request(endpoint) { (response) in
            completion(ArticleEntity.map(items: response.results))
        } error: { (apiError) in
            error(ErrorEntity(apiModel: apiError))
        }
    }
    
    //MARK: - Private Methdos
    
    private func getPath(with searchItem: SearchItemEntity) -> String {
        switch searchItem.type {
        case .mostmailed:
            return APIPath.Articles.mostmailed(searchItem.periodTimeType.apiString).path
        case .mostshared:
            return APIPath.call(APIPath.Articles.mostshared(searchItem.periodTimeType.apiString, searchItem.sharedType.apiString)).path
        case .mostviewed:
            return APIPath.call(APIPath.Articles.mostviewed(searchItem.periodTimeType.apiString)).path
        }
    }
}
