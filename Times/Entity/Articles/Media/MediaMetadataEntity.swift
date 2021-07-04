//
//  MediaMetadataEntity.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class MediaMetadataEntity {
    
    //MARK: - Public Properties
    
    public let url: String
    
    //MARK: - Initializers
    
    required public init(apiModel: MediaMetadataApiModel) {
        self.url = apiModel.url
    }
    
    //MARK: - Mappers
    
    class func map(items: [MediaMetadataApiModel]) -> [MediaMetadataEntity] {
        var metadata: [MediaMetadataEntity] = []
        for item in items { metadata.append(MediaMetadataEntity(apiModel: item)) }
        return metadata
    }
}
