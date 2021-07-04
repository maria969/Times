//
//  SelectorItemTableViewCell.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation
import UIKit

protocol SelectorItemTableViewCellDelegate: class {
    func cell(_ cell: SelectorItemTableViewCell, forItem item: SearchItemUiModel)
}

class SelectorItemTableViewCell: UITableViewCell {
    
    //MARK: - Public Properties
    
    public weak var delegate: SelectorItemTableViewCellDelegate?
    
    //MARK: - Private Properties
    
    private var radioButton: RadioButton = {
        let radioButton: RadioButton = RadioButton(item: RadioButtonItem(title: "new"))
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        return radioButton
    }()
    
    private var searchItem: SearchItemUiModel!
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureView()
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.selectionStyle = .none
        self.configureRadioButton()
    }
    
    private func configureRadioButton() {
        self.contentView.addSubview(self.radioButton)
        self.radioButton.top(withView: self.contentView, constant: 10.0)
        self.radioButton.bottom(withView: self.contentView, constant: -10.0)
        self.radioButton.leading(withView: self.contentView, constant: 20.0)
        self.radioButton.trailing(withView: self.contentView, constant: -10.0)
        self.radioButton.height(constant: 40.0)
        self.radioButton.onSelection = { [weak self] (radioButton) in
            self?.didTapCell()
        }
    }
    
    //MARK: - Public Methods
    
    public func configure(with searchItem: SearchItemUiModel) {
        self.searchItem = searchItem
        self.radioButton.titleLabel.text = searchItem.title
        self.radioButton.isSelected = searchItem.isSelected
    }
    
    //MARK: - Events
    
    @objc private func didTapCell() {
        self.delegate?.cell(self, forItem: self.searchItem)
    }
}
