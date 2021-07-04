//
//  DecodableResult.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class DecodableResult<T: Decodable>: Decodable {
    
    //MARK: - Public Properties
    
    public var result: T
    
    //MARK: - CodingKeys
    
    public enum DecodableResultCodingKeys: String, CodingKey {
        case result
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DecodableResultCodingKeys.self)
        self.result = try values.decode(T.self, forKey: .result)
    }
}
