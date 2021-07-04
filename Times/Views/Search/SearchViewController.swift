//
//  SearchViewController.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import UIKit

class SearchViewController: BaseViewController {
    
    //MARK: - Public Properties
    
    //MARK: - Private Properties
    
    private let presenter: SearchPresenterInterface
    private let routing: SearchWireFrameInterface
    
    private lazy var tableView: SearchTableView = {
        let tableView: SearchTableView = SearchTableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var searchButton: Button = {
        let button: Button = Button(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("times.search.view.search.button".localized(), for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.addTarget(self, action: #selector(tapSearchButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Intializers
    
    public init(presenter: SearchPresenterInterface,
                routing: SearchWireFrameInterface) {
        self.presenter = presenter
        self.routing = routing
        super.init(nibName: nil, bundle: nil)
        self.presenter.assingView(self)
    }
    
    @available(*, unavailable, message: "This initialized is not accessible. Use init(presenter: SearchPresenterInterface) instead.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("This initialized is not accessible. Use init(presenter: SearchPresenterInterface) instead.")
    }
    
    @available(*, unavailable, message: "This initialized is not accessible. Use init(presenter: SearchPresenterInterface) instead.")
    required init?(coder: NSCoder) {
        fatalError("This initialized is not accessible. Use init(presenter: SearchPresenterInterface) instead.")
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
        self.tableView.configure()
    }
    
    private func layoutSubviews() {
        self.view.backgroundColor = UIColor.white
        self.title = "times.search.view.title".localized()
        self.configureTableView()
        self.configureButton()
    }
    
    private func configureTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.top(withView: self.view)
        self.tableView.bottom(withView: self.view, constant: -50.0, toSafeArea: true)
        self.tableView.leading(withView: self.view)
        self.tableView.trailing(withView: self.view)
        self.tableView.delegate = self
    }
    
    private func configureButton() {
        self.view.addSubview(self.searchButton)
        self.searchButton.bottom(withView: self.view, toSafeArea: true)
        self.searchButton.trailing(withView: self.view, constant: -20.0)
        self.searchButton.leading(withView: self.view, constant: 20.0)
        self.searchButton.height(constant: 40.0)
    }
    
    //MARK: - Events
    
    @objc private func tapSearchButton() {
        self.presenter.searchNews(with: self.tableView.searchItem) { [weak self]
            (articles) in
            guard let strongSelf: SearchViewController = self else { return }
            self?.routing.presentResults(articles: articles, fromView: strongSelf)
        }
    }
}

//MARK: - SearchViewControllerInterface

extension SearchViewController: SearchViewControllerInterface {}

//MARK: - SearchTableViewDelegate

extension SearchViewController: SearchTableViewDelegate {}
