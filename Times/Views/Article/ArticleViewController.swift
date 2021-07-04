//
//  ArticleViewController.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import UIKit
import WebKit

class ArticleViewController: BaseViewController {
    
    //MARK: - Public Properties
    
    public var article: ArticleEntity!
    
    //MARK: - Private Properties
    
    private lazy var webView: WKWebView = {
        let view: WKWebView = WKWebView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()
    
    //MARK: - Intializers
    
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
        self.loadArticle()
    }
    
    private func layoutSubviews() {
        self.view.backgroundColor = UIColor.white
        self.configureWebView()
        self.title = "times.article.view.title".localized()
    }
    
    private func configureWebView() {
        self.view.addSubview(self.webView)
        self.webView.top(withView: self.view)
        self.webView.bottom(withView: self.view, toSafeArea: true)
        self.webView.leading(withView: self.view)
        self.webView.trailing(withView: self.view)
        self.webView.navigationDelegate = self
    }
    
    //MARK: - Private Methods
    
    private func loadArticle() {
        self.showLoading()
        guard let article: URL = URL(string: self.article.url) else { return }
        let request: URLRequest = URLRequest(url: article)
        self.webView.load(request)
    }
}

//MARK: - ArticleViewControllerInterface

extension ArticleViewController: ArticleViewControllerInterface {
    func assign(article: ArticleEntity) {
        self.article = article
    }
}

//MARK: - WKNavigationDelegate

extension ArticleViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideLoading()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.hideLoading()
    }
}
