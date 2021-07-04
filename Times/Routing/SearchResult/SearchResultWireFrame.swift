//
//  SearchResultWireFrame.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import UIKit
import Resolver

//MARK: - SearchResultWireFrameInterface

public class SearchResultWireFrame: SearchResultWireFrameInterface {
    
    //MARK: - Public Methods
    
    public func presentDetail(article: ArticleEntity, fromView view: SearchResultViewControllerInterface) {
        let viewController: UIViewController = view.viewController
        guard let navigationController: UINavigationController = viewController.navigationController else { return }
        
        let detailVC: ArticleViewControllerInterface = Resolver.resolve()
        detailVC.assign(article: article)
        
        navigationController.pushViewController(detailVC.viewController, animated: true)
    }
}
