//
//  Mappable.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public protocol ApiMappable: AnyObject {
    associatedtype ApiModel: Decodable
    
    init(apiModel: ApiModel)
    init?(optionalApiModel: ApiModel?)
}
