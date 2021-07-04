//
//  SearchTableView.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation
import UIKit

class SearchTableView: UIView {
    
    //MARK: - Public Properties
    
    public weak var delegate: SearchTableViewDelegate?
    public var sections: [SearchSectionUiModel]
    
    public var searchItem: SearchItemEntity = SearchItemEntity()
    
    //MARK: - Private Properties
    
    private var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        self.sections = []
        super.init(frame: frame)
        self.configureView(with: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.sections = []
        super.init(coder: aDecoder)
        self.configureView(with: .zero)
    }
    
    //MARK: - Layout
    
    private func configureView(with frame: CGRect) {
        self.configureTableView(with: frame)
    }
    
    private func configureTableView(with frame: CGRect) {
        self.addSubview(self.tableView)
        self.tableView.top(withView: self)
        self.tableView.bottom(withView: self)
        self.tableView.leading(withView: self)
        self.tableView.trailing(withView: self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.registerCells()
    }
    
    //MARK: - Private Methods
    
    private func registerCells() {
        self.tableView.register(SelectorItemTableViewCell.self, forCellReuseIdentifier: "SelectorItemCell")
        self.tableView.register(SearchSectionHeader.self, forHeaderFooterViewReuseIdentifier: "HeaderSection")
    }
    
    private func cell(for tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SelectorItemCell", for: indexPath)
        guard let itemCell: SelectorItemTableViewCell = cell as? SelectorItemTableViewCell else { return cell }
        let item: SearchItemUiModel = self.sections[indexPath.section].items[indexPath.row]
        itemCell.configure(with: item)
        itemCell.delegate = self
        return itemCell
    }
}

//MARK: - SearchTableViewInterface

extension SearchTableView: SearchTableViewInterface {
    func configure() {
        self.sections = self.searchItem.generateItems()
        self.reloadData()
    }
    
    func reloadData() {
        self.tableView.separatorStyle = .none
        self.tableView.reloadData()
    }
}

//MARK: - SelectorItemTableViewCellDelegate

extension SearchTableView: SelectorItemTableViewCellDelegate {
    func cell(_ cell: SelectorItemTableViewCell, forItem item: SearchItemUiModel) {
        self.sections = self.searchItem.updateItems(item: item)
        self.reloadData()
    }
}

//MARK: - UITableViewDataSource

extension SearchTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.cell(for: tableView, atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSection: UITableViewHeaderFooterView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderSection")
        guard let searchSection: SearchSectionHeader = headerSection as? SearchSectionHeader else { return headerSection }
        let sectionItem: SearchSectionUiModel = self.sections[section]
        searchSection.configureHeader(section: sectionItem)
        
        return searchSection
    }
}

//MARK: - UITableViewDelegate

extension SearchTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
}
