//
//  UITableView+Extension.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public extension UITableView {
    
    //MARK: - Public Methods
    
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ headerFooterClass: T.Type) {
        self.register(headerFooterClass, forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let reuseIdentifier: String = String(describing: T.self)
        guard let cell: T = self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T else {
            let errorString: String = String(format: "Unable to dequeue %@ with reuseId of %@", String(describing: cellClass), reuseIdentifier)
            fatalError(errorString)
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerFooterClass: T.Type) -> T {
        let reuseIdentifier: String = String(describing: T.self)
        guard let headerFooterView: T = self.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? T else {
            let errorString: String = String(format: "Unable to dequeue %@ with reuseId of %@", String(describing: headerFooterClass), reuseIdentifier)
            fatalError(errorString)
        }
        return headerFooterView
    }
}
