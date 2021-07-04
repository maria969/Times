//
//  SearchSectionHeader.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

class SearchSectionHeader: UITableViewHeaderFooterView {
    
    //MARK: - Private Properties
    
    private var backgroundSectionView: UIView = {
        let view: UIView = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label: UILabel = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.medium)
        label.textAlignment = NSTextAlignment.left
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private var separatorView: UIView = {
        let view: UIView = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    //MARK: - Initializers
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureView()
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.configureBackgroundSectionView()
        self.configureTitleLabel()
        self.configureSeparatorView()
    }
    
    private func configureBackgroundSectionView() {
        self.addSubview(self.backgroundSectionView)
        self.backgroundSectionView.top(withView: self)
        self.backgroundSectionView.bottom(withView: self)
        self.backgroundSectionView.leading(withView: self)
        self.backgroundSectionView.trailing(withView: self)
    }
    
    private func configureTitleLabel() {
        self.addSubview(self.titleLabel)
        self.titleLabel.top(withView: self, constant: 20.0)
        self.titleLabel.leading(withView: self, constant: 12.0)
        self.titleLabel.trailing(withView: self, constant: -12.0)
    }
    
    private func configureSeparatorView() {
        self.addSubview(self.separatorView)
        self.separatorView.top(toBottom: self.titleLabel, fromView: self, constant: 2.0)
        self.separatorView.bottom(withView: self, constant: -10.0, priority: 900)
        self.separatorView.leading(withView: self, constant: 12.0)
        self.separatorView.trailing(withView: self, constant: -12.0)
        self.separatorView.height(constant: 1.0)
    }
    
    //MARK: - Public Methods
    
    public func configureHeader(section: SearchSectionUiModel) {
        self.titleLabel.text = section.title
    }
}
