//
//  DataAssembly.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Resolver

//MARK: - Data Injections

extension Resolver {
    
    //MARK: - Public Methods
    
    static func registerDataComponents() {
        self.registerGetArticlesApiSource()
    }
    
    //MARK: - Private Methods
    
    private static func registerGetArticlesApiSource() {
        self.register { GetArticlesApiSource(client: self.resolve()) as GetArticlesApiSourceInterface }
    }
}
