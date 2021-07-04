//
//  ServerURL.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public final class ServerURL {
    
    //MARK: - Public Properties
    
    public var baseURL: URL {
        return URL(string: self.apiPath)!
    }
    
    //MARK: - Private Properties
    
    private static let URLFormat: String = "%@://%@"
    
    private let apiPath: String
    
    //MARK: - Initializers
    
    public required init(host: String, isSecure: Bool = true) {
        let scheme: String = ServerURL.scheme(for: isSecure)
        self.apiPath = String(format: ServerURL.URLFormat, scheme, host)
    }
    
    //MARK: - Private Methods
    
    private class func scheme(for secure: Bool) -> String {
        guard secure else { return ApiConstants.Identifiers.HTTP }
        return ApiConstants.Identifiers.HTTPS
    }
}
