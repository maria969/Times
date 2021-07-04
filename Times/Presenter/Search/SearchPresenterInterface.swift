//
//  SearchPresenterInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

protocol SearchPresenterInterface: PresenterInterface {
    func searchNews(with searchItem: SearchItemEntity, completion: @escaping SearchPresenter.Completion)
}
