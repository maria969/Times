//
//  ResponseResult.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class ResponseResult<T: Decodable>: Decodable {
    
    //MARK: - Public Properties
    
    public let results: T
    
    public enum ResponseResultCodingKeys: String, CodingKey {
        case results
    }
    
    //MARK: - Initializers
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ResponseResultCodingKeys.self)
        self.results = try values.decode(T.self, forKey: .results)
    }
}
