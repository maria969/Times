//
//  MediaMetadataApiModel.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class MediaMetadataApiModel: Decodable {
    
    //MARK: - Public Properties
    
    public let url: String
    
    //MARK: - CodingKeys
    
    public enum MediaMetadataApiModelCodingKeys: String, CodingKey {
        case url
    }
    
    //MARK: - Initializers
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: MediaMetadataApiModelCodingKeys.self)
        self.url = try values.decode(String.self, forKey: .url)
    }
}
