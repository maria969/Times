//
//  ArticleEntity.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class ArticleEntity {
   
    //MARK: - Public Properties
    
    public let id: Int
    public let url: String
    public let title: String?
    public let author: String?
    public let publishedDate: String?
    public let section: String?
    public let media: [MediaEntity]?
    
    //MARK: - Initializers
    
    required public init(apiModel: ArticleApiModel) {
        self.id = apiModel.id
        self.url = apiModel.url
        self.title = apiModel.title
        self.author = apiModel.author
        self.publishedDate = apiModel.publishedDate
        self.section = apiModel.section
        if let mediaApiModel: [MediaApiModel] = apiModel.media {
            self.media = MediaEntity.map(items: mediaApiModel)
        }
        else { self.media = nil }
    }
    
    //MARK: - Mappers
    
    class func map(items: [ArticleApiModel]) -> [ArticleEntity] {
        var articles: [ArticleEntity] = []
        for item in items { articles.append(ArticleEntity(apiModel: item)) }
        return articles
    }
}
