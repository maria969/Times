//
//  RadioButtonIndicatorView.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public class RadioButtonIndicatorView: UIView {
    
    //MARK: - Public Properties
    
    public var isSelected: Bool = false {
        didSet { self.configureColors() }
    }
    
    public var selectedColor: UIColor = UIColor.systemBlue {
        didSet { self.configureColors() }
    }
    
    public var unselectedColor: UIColor = UIColor.lightGray {
        didSet { self.configureColors() }
    }
    
    public var ringWidth: CGFloat = 2.0 {
        didSet { self.layer.borderWidth = self.ringWidth }
    }
    
    public var size: CGFloat = 24.0 {
        didSet {
            self.outRingWidthConstraint?.constant = self.size
            self.outRingHeightConstraint?.constant = self.size
        }
    }
    
    public var selectedViewInset: CGFloat = 5.0 {
        didSet {
            let viewSize: CGFloat = self.size - (self.selectedViewInset * 2.0)
            self.selectedViewWidthConstraint?.constant = viewSize
            self.selectedViewHeightConstraint?.constant = viewSize
        }
    }
    
    //MARK: - Private Properties
    
    private var selectedView: UIView = RadioButtonIndicatorView.createSelectedView()
    
    private var outRingWidthConstraint: NSLayoutConstraint?
    private var outRingHeightConstraint: NSLayoutConstraint?
    private var selectedViewWidthConstraint: NSLayoutConstraint?
    private var selectedViewHeightConstraint: NSLayoutConstraint?
    
    //MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.selectedView.layer.cornerRadius = self.selectedView.frame.size.height/2.0
        self.layer.cornerRadius = self.frame.height/2.0
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.outRingWidthConstraint = self.width(constant: self.size)
        self.outRingHeightConstraint = self.height(constant: self.size)
        self.layer.borderWidth = self.ringWidth
        self.configureSelectedView()
        self.configureColors()
    }
    
    private func configureSelectedView() {
        self.addSubview(self.selectedView)
        self.selectedView.centerX(withView: self)
        self.selectedView.centerY(withView: self)
        
        let viewSize: CGFloat = self.size - (self.selectedViewInset * 2.0)
        self.selectedViewWidthConstraint = self.selectedView.width(constant: viewSize)
        self.selectedViewHeightConstraint = self.selectedView.height(constant: viewSize)
    }
    
    private class func createSelectedView() -> UIView {
        let view: UIView = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    //MARK: - Private Methods
    
    private func configureColors() {
        if self.isSelected {
            self.layer.borderColor = self.selectedColor.cgColor
            self.selectedView.backgroundColor = self.selectedColor
        }
        else {
            self.layer.borderColor = self.unselectedColor.cgColor
            self.selectedView.backgroundColor = UIColor.clear
        }
    }
}
