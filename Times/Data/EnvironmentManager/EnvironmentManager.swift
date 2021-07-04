//
//  EnvironmentManager.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class EnvironmentManager: EnvironmentManagerInterface {
    
    //MARK: - Private Properties
    
    private let _environment: EnvironmentInterface
    
    //MARK: - Initializers
    
    public init() {
        self._environment = Environment()
    }
    
    //MARK: - Public Methods
    
    public func environment() -> EnvironmentInterface {
        return self._environment
    }
    
    public func environmentType() -> EnvironmentType {
        return self._environment.environmentType()
    }
}
