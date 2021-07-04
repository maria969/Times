//
//  RoutingAssembly.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Resolver

//MARK: - Routing Injections

extension Resolver {
    
    //MARK: - Public Methods
    
    static func registerRoutingComponents() {
        self.registerSearchWireFrame()
        self.registerSearchResultWireFrame()
    }
    
    //MARK: - Private Methods
    
    private static func registerSearchWireFrame() {
        self.register { SearchWireFrame() as SearchWireFrameInterface }
    }
    
    private static func registerSearchResultWireFrame() {
        self.register { SearchResultWireFrame() as SearchResultWireFrameInterface }
    }
}
