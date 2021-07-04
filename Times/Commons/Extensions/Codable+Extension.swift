//
//  Codable+Extension.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public extension Encodable {
    
    //MARK: - Public Methods
    
    func encode() throws -> Data {
        let encoder: JSONEncoder = JSONEncoder()
        encoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
        return try encoder.encode(self)
    }
    
    func asDictionary() throws -> [String: Any] {
        let data: Data = try self.encode()
        guard let dictionary: [String: Any] = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] else {
            throw NSError(domain: "com.mariaherrerovaras.times",
                          code: 100,
                          userInfo: [NSLocalizedDescriptionKey : "Object could not be encoded"])
        }
        return dictionary
    }
    
    func asString() throws -> String {
        let data: Data = try self.encode()
        guard let result: String = String(data: data, encoding: .utf8) else { return "" }
        return result
    }
    
    func asURLEncodedParameters() -> [String: Any] {
        do {
            return try self.asDictionary()
        } catch { return [:] }
    }
}
