//
//  SafeDecodable.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public protocol SafeDecoding {
    associatedtype Value: Decodable
    var value: Value? { get }
    var error: Error? { get }
}

public final class SafeDecodable<T: Decodable>: Decodable, SafeDecoding {
    
    //MARK: - Public Properties
    
    public var value: T? {
        switch self.result {
        case Result.success(let containerValue):
            return containerValue
        case Result.failure:
            return nil
        }
    }
    
    public var error: Error? {
        switch self.result {
        case Result.success:
            return nil
        case Result.failure(let error):
            return error
        }
    }
    
    //MARK: - Private Properties
    
    private let result: Result<T, Error>
    
    //MARK: - Initializers
    
    required public init(from decoder: Decoder) throws {
        self.result = Result(catching: { try T(from: decoder) })
    }
}

//MARK: - Array Methods

public extension Array where Element: SafeDecoding {
    
    //MARK: - Public Properties
    
    var items: [Element.Value] {
        var values: [Element.Value] = []
        for item in self {
            guard let value: Element.Value = item.value else { continue }
            values.append(value)
        }
        return values
    }
}
