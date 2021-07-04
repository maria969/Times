//
//  UIWindow+Extension.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public extension UIWindow {
    
    private static let UITextEffectClassName: String = "UITextEffectsWindow"
    
    //MARK: - Public Properties
    
    static var main: UIWindow? {
        return self.keyWindow
    }
    
    static var top: UIWindow? {
        return self.topWindow
    }
    
    static var textEffects: UIWindow? {
        return self.textEffectsWindow
    }
    
    //MARK: - Private Properties
    
    private static var keyWindow: UIWindow? {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }
    
    private static var topWindow: UIWindow? {
        return UIApplication.shared.windows.last
    }
    
    private static var textEffectsWindow: UIWindow? {
        guard let clazz: AnyClass = NSClassFromString(UIWindow.UITextEffectClassName) else { return nil }
        return UIApplication.shared.windows.first { $0.isKind(of: clazz) }
    }
}
