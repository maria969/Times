//
//  SearchWireFrame.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import UIKit
import Resolver

//MARK: - SearchWireFrameInterface

public class SearchWireFrame: SearchWireFrameInterface {
    
    //MARK: - Public Methods
    public func presentResults(articles: [ArticleEntity], fromView view: SearchViewControllerInterface) {
        let viewController: UIViewController = view.viewController
        guard let navigationController: UINavigationController = viewController.navigationController else { return }
        
        let resultVC: SearchResultViewControllerInterface = Resolver.resolve()
        resultVC.assign(articles: articles)
        
        navigationController.pushViewController(resultVC.viewController, animated: true)
    }
}
