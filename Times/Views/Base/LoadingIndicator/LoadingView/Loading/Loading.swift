//
//  Loading.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public protocol Loading: UIViewController {
    var isViewReady: Bool { get }
}

extension UIViewController: PropertyStoring, Loading {
    
    //MARK: - Public Properties
    
    @objc open var isViewReady: Bool {
        return self.viewReady
    }
    
    public var viewReady: Bool {
        get { return self._viewReady.reader { $0 } }
        set {
            self.willChangeValue(forKey: #keyPath(isViewReady))
            self._viewReady.writer { $0 = newValue }
            self.didChangeValue(forKey: #keyPath(isViewReady))
        }
    }
    
    //MARK: - Private Properties
    
    private struct ExtendedProperties {
        static var viewReady: UInt8 = 0
    }
    
    private var _viewReady: Synchronized<Bool> {
        get {
            guard let viewReady: Synchronized<Bool> = self.getAssociatedObject(&ExtendedProperties.viewReady) else {
                let new: Synchronized<Bool> = Synchronized<Bool>(false)
                self._viewReady = new
                return new
            }
            return viewReady
        }
        set { self.setAssociatedObject(newValue, for: &ExtendedProperties.viewReady, policy: PropertyStoringAssociationPolicy.strong) }
    }
}
