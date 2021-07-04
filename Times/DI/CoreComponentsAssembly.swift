//
//  CoreComponentsAssembly.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Resolver

//MARK: - Core Injections

extension Resolver {
    
    //MARK: - Public Methods
    
    static func registerCoreComponents() {
        self.registerEnvironmentManager()
        self.registerApiRequester()
    }
    
    //MARK: - Private Methods
    
    private static func registerEnvironmentManager() {
        self.register { EnvironmentManager() as EnvironmentManagerInterface }
            .scope(ResolverScope.application)
    }
    
    private static func registerApiRequester() {
        self.register { ApiRequester(environment: self.resolve()) as ApiRequesterInterface }
            .scope(ResolverScope.application)
    }
}
