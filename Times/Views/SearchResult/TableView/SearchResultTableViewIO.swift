//
//  SearchResultTableViewIO.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

protocol SearchResultTableViewInterface: AnyObject {
    var delegate: SearchResultTableViewDelegate? { get set }
    
    func configure(with articles: [ArticleEntity])
    func reloadData()
}

protocol SearchResultTableViewDelegate: AnyObject {
    func tableView(tableView: SearchResultTableView, didTapArticle article: ArticleEntity)
}
