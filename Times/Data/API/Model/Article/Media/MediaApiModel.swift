//
//  MediaApiModel.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class MediaApiModel: Decodable {
    
    //MARK: - Public Properties
    
    public let type: String
    public let metadata: [MediaMetadataApiModel]
    
    //MARK: - CodingKeys
    
    public enum MediaMetadataApiModelCodingKeys: String, CodingKey {
        case type
        case metadata = "media-metadata"
    }
    
    //MARK: - Initializers
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: MediaMetadataApiModelCodingKeys.self)
        self.type = try values.decode(String.self, forKey: .type)
        self.metadata = try values.decode([MediaMetadataApiModel].self, forKey: .metadata)
    }
}
