//
//  ArticleApiModel.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class ArticleApiModel: Decodable {
    
    //MARK: - Public Properties
    
    public let id: Int
    public let url: String
    public let title: String?
    public let author: String?
    public let publishedDate: String?
    public let section: String?
    public let media: [MediaApiModel]?
    
    //MARK: - CodingKeys
    
    public enum ArticleApiModelCodingKeys: String, CodingKey {
        case id
        case url
        case title
        case author = "byline"
        case publishedDate = "published_date"
        case section
        case media
    }
    
    //MARK: - Initializers
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ArticleApiModelCodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.url = try values.decode(String.self, forKey: .url)
        self.title = try values.decodeIfPresent(String.self, forKey: .title)
        self.author = try values.decodeIfPresent(String.self, forKey: .author)
        self.publishedDate = try values.decodeIfPresent(String.self, forKey: .publishedDate)
        self.section = try values.decodeIfPresent(String.self, forKey: .section)
        self.media = try values.decodeIfPresent([MediaApiModel].self, forKey: .media)
    }
}
