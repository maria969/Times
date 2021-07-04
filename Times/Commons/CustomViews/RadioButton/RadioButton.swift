//
//  RadioButton.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public class RadioButton: UIView {
    
    public typealias Selection = (_ button: RadioButton) -> Void
    
    //MARK: - Public Properties
    
    public var isSelected: Bool = false {
        didSet {
            self.indicatorView.isSelected = self.isSelected
            self.configureColors()
        }
    }
    
    public var titleLabel: UILabel = RadioButton.createTitleLabel()
    public var indicatorView: RadioButtonIndicatorView = RadioButton.createIndicatorView()
    public var itemView: UIView = RadioButton.createItemView()
    
    public var onSelection: RadioButton.Selection?
    
    //MARK: - Private Properties
    
    private var titleStackView: UIStackView = RadioButton.createTitleStackView()
    private var separatorView: UIView = RadioButton.createSeparatorView()
    private var tapGestureRecognizer: UITapGestureRecognizer?
    
    private var itemHeightConstraint: NSLayoutConstraint?
    private var subtitleOffsetConstraint: NSLayoutConstraint?
    private var separatorOffsetConstraint: NSLayoutConstraint?
    
    //MARK: - Initializers
    
    public init(item: RadioButtonItem) {
        super.init(frame: CGRect.zero)
        self.configureView(with: item)
    }
    
    @available(*, unavailable, message: "This initializer is not accessible. Use init(item: RadioButtonItem) instead")
    override init(frame: CGRect) {
        super.init(frame: frame)
        assert(false, "This initializer is not accessible. Use init(item: RadioButtonItem) instead")
    }
    
    @available(*, unavailable, message: "This initializer is not accessible. Use init(item: RadioButtonItem) instead")
    public required init?(coder: NSCoder) {
        assert(false, "This initializer is not accessible. Use init(item: RadioButtonItem) instead")
        return nil
    }
    
    deinit {
        guard let tapGestureRecognizer: UITapGestureRecognizer = self.tapGestureRecognizer else { return }
        self.removeGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: - Layout
    
    private func configureView(with item: RadioButtonItem) {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.titleLabel.text = item.title
        self.configureStyle()
        self.configureColors()
        self.configureTapGestureRecognizer()
    }
    
    private func configureStyle() {
        self.configureItemView()
        self.configureTitleStackView()
        self.configureSeparatorView()
    }
    
    
    private func configureItemView() {
        self.addSubview(self.itemView)
        self.itemView.top(withView: self)
        self.itemView.leading(withView: self)
        self.itemView.trailing(withView: self)
        self.itemHeightConstraint = self.itemView.height(constant: 50.0)
    }
    
    private func configureTitleStackView() {
        self.itemView.addSubview(self.titleStackView)
        self.titleStackView.leading(withView: self.itemView)
        self.titleStackView.trailing(withView: self.itemView)
        self.titleStackView.centerY(withView: self.itemView)
        self.titleStackView.addArrangedSubview(self.indicatorView)
        self.titleStackView.addArrangedSubview(self.titleLabel)
    }
    
    private func configureSeparatorView() {
        self.addSubview(self.separatorView)
        self.separatorView.bottom(withView: self)
        self.separatorView.leading(toView: self.titleLabel, fromView: self)
        self.separatorView.trailing(toView: self.titleLabel, fromView: self)
        self.separatorView.height(constant: 0.5)
    }
    
    private func configureTapGestureRecognizer() {
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapButton))
        self.addGestureRecognizer(tapGestureRecognizer)
        self.tapGestureRecognizer = tapGestureRecognizer
    }
    
    private class func createTitleLabel() -> UILabel {
        let label: UILabel = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.medium)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.black
        return label
    }
    
    private class func createIndicatorView() -> RadioButtonIndicatorView {
        let view: RadioButtonIndicatorView = RadioButtonIndicatorView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private class func createItemView() -> UIView {
        let view: UIView = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private class func createTitleStackView() -> UIStackView {
        let view: UIStackView = UIStackView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = NSLayoutConstraint.Axis.horizontal
        view.alignment = UIStackView.Alignment.fill
        view.spacing = 12.0
        return view
    }
    
    private class func createSeparatorView() -> UIView {
        let view: UIView = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    //MARK: - Private Methods
    
    private func configureColors() {
        if self.isSelected {
            self.titleLabel.textColor = UIColor.blue
        }
        else {
            self.titleLabel.textColor = UIColor.black
        }
        self.separatorView.backgroundColor = UIColor.lightGray
    }
    
    //MARK: - Events
    
    @objc private func tapButton() {
        self.onSelection?(self)
    }
}
