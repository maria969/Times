//
//  SearchResultWireFrameInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

public protocol SearchResultWireFrameInterface: AnyObject {
    func presentDetail(article: ArticleEntity, fromView view: SearchResultViewControllerInterface)
}
