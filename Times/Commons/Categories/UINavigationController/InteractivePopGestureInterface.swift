//
//  InteractivePopGestureInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

protocol InteractivePopGestureInterface: class {
    func isInteractivePopGestureEnabled() -> Bool
    func navigationControllerWillPopBack()
}

//MARK: - InteractivePopGestureInterface

extension UIViewController: InteractivePopGestureInterface {
    @objc func isInteractivePopGestureEnabled() -> Bool {
        return true
    }
    
    @objc func navigationControllerWillPopBack() {
        // Must be implemented for each ViewController that needs execute
        // something before the pop animation commits
    }
}
