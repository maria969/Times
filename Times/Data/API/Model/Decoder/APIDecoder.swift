//
//  APIDecoder.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public final class APIDecoder {
    
    //MARK: - Public Methods
    
    public class func decode<T: Decodable>(_ type: T.Type, from response: DataApiResponse) -> T? {
        guard let data: Data = response.body else { return nil }
        do {
            let model: T = try data.decode(type)
            return model
        } catch {
            return nil
        }
    }
    
    public class func decode<T: Decodable>(_ type: T.Type, fromData data: Data?) -> T? {
        guard let dataToDecode: Data = data else { return nil }
        do {
            let model: T = try dataToDecode.decode(type)
            return model
        } catch {
            return nil
        }
    }
}

//MARK: - Data Decoding

private extension Data {
    func simpleDecode<T: Decodable>(_ type: T.Type) throws -> T {
        let decoder: JSONDecoder = JSONDecoder()
        return try decoder.decode(type, from: self)
    }
    
    func decode<T: Decodable>(_ type: T.Type) throws -> T {
        do {
            return try self.simpleDecode(type)
        }
        catch DecodingError.dataCorrupted(let context) {
            guard let value: T = self.fragmentDecode(type) else { throw DecodingError.dataCorrupted(context) }
            return value
        }
        catch { throw error }
    }
    
    //MARK: - Private Methods
    
    private func fragmentDecode<T: Decodable>(_ type: T.Type) -> T? {
        do {
            let object: Any = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.allowFragments)
            guard let value: T = object as? T else { return nil }
            return value
        }
        catch { return nil }
    }
}
