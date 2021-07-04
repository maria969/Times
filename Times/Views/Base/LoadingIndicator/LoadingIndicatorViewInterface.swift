//
//  LoadingIndicatorViewInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public protocol LoadingIndicatorInterface: LoadingViewInterface {
    init(message: String, viewController: LoadingIndicator.Origin?)
    
    func configure(message: String)
    func start()
    func stop()
    func start(withView view: UIViewController)
    func stop(withView view: UIViewController)
}
