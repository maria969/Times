//
//  UIActivityIndicatorView+Extension.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    
    //MARK: - Public Properties
    
    public static var whiteLarge: Self {
        let indicator: Self = Self.init(style: UIActivityIndicatorView.Style.defaultWhiteLarge)
        indicator.color = UIColor.white
        return indicator
    }
    
    public static var white: Self {
        let indicator: Self = Self.init(style: UIActivityIndicatorView.Style.defaultWhite)
        indicator.color = UIColor.white
        return indicator
    }
    
    public static var gray: Self {
        let indicator: Self = Self.init(style: UIActivityIndicatorView.Style.defaultGray)
        indicator.color = UIColor.gray
        return indicator
    }
    
    //MARK: - Public Methods
    
    public func whiteLarge() {
        self.style = UIActivityIndicatorView.Style.defaultWhiteLarge
        self.color = UIColor.white
    }
    
    public func white() {
        self.style = UIActivityIndicatorView.Style.defaultWhite
        self.color = UIColor.white
    }
    
    public func gray() {
        self.style = UIActivityIndicatorView.Style.defaultGray
        self.color = UIColor.gray
    }
}

extension UIActivityIndicatorView.Style {
    
    //MARK: - Public Properties
    
    public static var defaultWhiteLarge: Self {
        guard #available(iOS 13.0, *) else { return UIActivityIndicatorView.Style.whiteLarge }
        return UIActivityIndicatorView.Style.large
    }
    
    public static var defaultWhite: Self {
        guard #available(iOS 13.0, *) else { return UIActivityIndicatorView.Style.white }
        return UIActivityIndicatorView.Style.medium
    }
    
    public static var defaultGray: Self {
        guard #available(iOS 13.0, *) else { return UIActivityIndicatorView.Style.gray }
        return UIActivityIndicatorView.Style.medium
    }
}
