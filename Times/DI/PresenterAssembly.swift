//
//  PresenterAssembly.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Resolver

//MARK: - Presenter Injections

extension Resolver {
    
    //MARK: - Public Methods
    
    static func registerPresenterComponents() {
        self.registerSearchPresenter()
    }
    
    //MARK: - Private Methods
    
    private static func registerSearchPresenter() {
        self.register { SearchPresenter(getArticlesInteractor: self.resolve()) as SearchPresenterInterface }
    }
}
