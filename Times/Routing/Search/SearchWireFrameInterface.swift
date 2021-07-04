//
//  SearchWireFrameInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

public protocol SearchWireFrameInterface: AnyObject {
    func presentResults(articles: [ArticleEntity], fromView view: SearchViewControllerInterface)
}
