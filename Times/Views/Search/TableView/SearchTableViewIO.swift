//
//  SearchTableViewIO.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

protocol SearchTableViewInterface: AnyObject {
    var delegate: SearchTableViewDelegate? { get set }
    
    func configure()
    func reloadData()
}

protocol SearchTableViewDelegate: AnyObject {
}
