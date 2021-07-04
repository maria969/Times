//
//  Button.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit
import MaterialComponents

open class Button: MDCButton {
    
    open func textButton(with title: String,
                         textColor: UIColor,
                         font: UIFont = UIFont.systemFont(ofSize: 21.0),
                         capitalized: Bool = true) {
        self.configureTextStyle(withFont: font, textColor: textColor)
        self.setTitle(title, for: .normal)
        self.isUppercaseTitle = capitalized
    }
    
    //MARK: - Private Methods
    
    private func configureTextStyle(withFont font: UIFont,
                                    textColor: UIColor) {
        let scheme: MDCContainerScheme = MDCContainerScheme()
        self.applyTextTheme(withScheme: scheme)
        self.setTitleFont(font, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.sizeToFit()
        self.inkColor = textColor.withAlphaComponent(0.2)
    }
}
