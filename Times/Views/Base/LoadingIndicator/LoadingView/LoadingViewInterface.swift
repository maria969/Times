//
//  LoadingViewInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public protocol LoadingViewInterface: class {
    var viewController: UIViewController? { get }
    
    init(frame: CGRect, viewController: Loading?)
}
