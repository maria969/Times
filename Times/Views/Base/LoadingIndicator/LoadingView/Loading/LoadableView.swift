//
//  LoadableView.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public protocol LoadableView: AnyObject {
    var window: UIWindow? { get }
}
