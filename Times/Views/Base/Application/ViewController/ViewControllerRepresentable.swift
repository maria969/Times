//
//  ViewControllerRepresentable.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public protocol ViewControllerRepresentable: ViewRepresentable {
    var viewController: UIViewController { get }
}

extension ViewControllerRepresentable {
    public var viewController: UIViewController {
        guard let viewController: UIViewController = self as? UIViewController else {
            let identifier: String = String(describing: self)
            fatalError("\(identifier) implements ViewControllerRepresentable but is not a UIViewController.")
        }
        return viewController
    }
}
