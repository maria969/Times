//
//  AppAssembly.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Resolver

//MARK: - App Injections

extension Resolver: ResolverRegistering {
    
    //MARK: - Public Methods
    
    public static func registerAllServices() {
        
        self.registerCoreComponents()
        self.registerDataComponents()
        self.registerRoutingComponents()
        self.registerDomainComponents()
        self.registerPresenterComponents()
        self.registerViewControllers()
    }
    
    //MARK: - Private Methods
    
    private static func registerViewControllers() {
        self.registerSearchViewController()
        self.registerSearchResultViewController()
    }
    
    private static func registerSearchViewController() {
        self.register { SearchViewController(presenter: self.resolve(),
                                             routing: self.resolve()) as SearchViewControllerInterface }
    }
    
    private static func registerSearchResultViewController() {
        self.register { SearchResultViewController(presenter: self.resolve(),
                                                   routing: self.resolve()) as SearchResultViewControllerInterface }
    }
}
