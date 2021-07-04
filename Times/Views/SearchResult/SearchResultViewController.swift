//
//  SearchResultViewController.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import UIKit

class SearchResultViewController: BaseViewController {
    
    //MARK: - Public Properties
    
    public var articles: [ArticleEntity]!
    
    //MARK: - Private Properties
    
    private let presenter: SearchResultPresenterInterface
    private let routing: SearchResultWireFrameInterface
    
    private lazy var tableView: SearchResultTableView = {
        let tableView: SearchResultTableView = SearchResultTableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - Intializers
    
    public init(presenter: SearchResultPresenterInterface, routing: SearchResultWireFrameInterface) {
        self.presenter = presenter
        self.routing = routing
        super.init(nibName: nil, bundle: nil)
        self.presenter.assingView(self)
    }
    
    @available(*, unavailable, message: "This initialized is not accessible. Use init(presenter: SearchResultPresenterInterface) instead.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("This initialized is not accessible. Use init(presenter: SearchResultPresenterInterface) instead.")
    }
    
    @available(*, unavailable, message: "This initialized is not accessible. Use init(presenter: SearchResultPresenterInterface) instead.")
    required init?(coder: NSCoder) {
        fatalError("This initialized is not accessible. Use init(presenter: SearchResultPresenterInterface) instead.")
    }
    
    override func loadView() {
        super.loadView()
        self.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.tableView.configure(with: self.articles)
    }
    
    private func layoutSubviews() {
        self.view.backgroundColor = UIColor.white
        self.title = "times.search_results.view.title".localized()
        self.configureTableView()
    }
    
    private func configureTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.top(withView: self.view)
        self.tableView.bottom(withView: self.view)
        self.tableView.leading(withView: self.view)
        self.tableView.trailing(withView: self.view)
        self.tableView.delegate = self
    }
}

//MARK: - SearchResultViewControllerInterface

extension SearchResultViewController: SearchResultViewControllerInterface {
    func assign(articles: [ArticleEntity]) {
        self.articles = articles
        self.tableView.configure(with: self.articles)
    }
}

//MARK: - SearchResultTableViewDelegate

extension SearchResultViewController: SearchResultTableViewDelegate {
    func tableView(tableView: SearchResultTableView, didTapArticle article: ArticleEntity) {
        self.routing.presentDetail(article: article, fromView: self)
    }
}
