//
//  DomainAssembly.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Resolver

//MARK: - Domain Injections

extension Resolver {
    
    //MARK: - Public Methods
    
    static func registerDomainComponents() {
        self.registerGetArticlesInteractor()
    }
    
    //MARK: - Private Methods
    
    private static func registerGetArticlesInteractor() {
        self.register { GetArticlesInteractor(getArticlesApiSource: self.resolve()) as GetArticlesInteractorInterface }
    }
}
