//
//  MediaEntity.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class MediaEntity {
    
    //MARK: - Public Properties
    
    public let type: String
    public let metadata: [MediaMetadataEntity]
    
    //MARK: - Initializers
    
    required public init(apiModel: MediaApiModel) {
        self.type = apiModel.type
        self.metadata = MediaMetadataEntity.map(items: apiModel.metadata)
    }
    
    //MARK: - Mappers
    
    class func map(items: [MediaApiModel]) -> [MediaEntity] {
        var media: [MediaEntity] = []
        for item in items { media.append(MediaEntity(apiModel: item)) }
        return media
    }
}
