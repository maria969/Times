//
//  SearchResultTableView.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation
import UIKit

class SearchResultTableView: UIView {
    
    //MARK: - Public Properties
    
    public weak var delegate: SearchResultTableViewDelegate?
    public var articles: [ArticleEntity]
    
    //MARK: - Private Properties
    
    private var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        self.articles = []
        super.init(frame: frame)
        self.configureView(with: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.articles = []
        super.init(coder: aDecoder)
        self.configureView(with: .zero)
    }
    
    //MARK: - Layout
    
    private func configureView(with frame: CGRect) {
        self.configureTableView(with: frame)
    }
    
    private func configureTableView(with frame: CGRect) {
        self.addSubview(self.tableView)
        self.tableView.top(withView: self)
        self.tableView.bottom(withView: self)
        self.tableView.leading(withView: self)
        self.tableView.trailing(withView: self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerCells()
    }
    
    //MARK: - Private Methods
    
    private func registerCells() {
        self.tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
    }
    
    private func cell(for tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
        guard let articleCell: ArticleTableViewCell = cell as? ArticleTableViewCell else { return cell }
        let article: ArticleEntity = self.articles[indexPath.row]
        articleCell.configure(with: article)
        articleCell.delegate = self
        return articleCell
    }
}

//MARK: - SearchResultTableViewInterface

extension SearchResultTableView: SearchResultTableViewInterface {
    func configure(with articles: [ArticleEntity]) {
        self.articles = articles
        self.reloadData()
    }
    
    func reloadData() {
        self.tableView.separatorStyle = .none
        self.tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource

extension SearchResultTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.cell(for: tableView, atIndexPath: indexPath)
    }
}

//MARK: - UITableViewDelegate

extension SearchResultTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
}

//MARK: - ArticleTableViewCelllDelegate

extension SearchResultTableView: ArticleTableViewCelllDelegate {
    func cellDidTap(_ cell: ArticleTableViewCell) {
        guard let indexPath: IndexPath = self.tableView.indexPath(for: cell) else { return }
        let article: ArticleEntity = self.articles[indexPath.row]
        self.delegate?.tableView(tableView: self, didTapArticle: article)
    }
}
