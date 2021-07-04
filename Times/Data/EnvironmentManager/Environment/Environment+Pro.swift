//
//  Environment+Pro.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class Environment: EnvironmentInterface {
    
    //MARK: - Private Properties
    
    private let _serverURL: ServerURL
    
    //MARK: - Initializers
    
    public init() {
        self._serverURL = ServerURL(host: "api.nytimes.com/svc/mostpopular/v2/", isSecure: true)
    }
    
    //MARK: - Public Methods
    
    public func environmentType() -> EnvironmentType {
        return EnvironmentType.pro
    }
    
    public func serverURL() -> ServerURL {
        return self._serverURL
    }
    
    public func timeout() -> Double {
        return 60.0
    }
    
    public func apiKey() -> String {
        return ""
    }
    
    /// This property includes all those headers that by default are sent to the api in for all requests
    /// - Returns: The headers dictionary
    public func headers() -> [String : String] {
        return [:]
    }
}
