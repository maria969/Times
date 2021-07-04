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
    
    //MARK: - Intializers
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "This initialized is not accessible. Use init(e) instead.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("This initialized is not accessible. Use init() instead.")
    }
    
    @available(*, unavailable, message: "This initialized is not accessible. Use init() instead.")
    required init?(coder: NSCoder) {
        fatalError("This initialized is not accessible. Use init() instead.")
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
    }
    
    private func layoutSubviews() {
        self.view.backgroundColor = UIColor.white
        self.title = "Search"
    }
}

//MARK: - SearchViewControllerInterface

extension SearchViewController: SearchViewControllerInterface {}

