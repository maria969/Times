//
//  UIView+Extension.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public extension UIView {
    
    private enum YAnchorEnumType: Int {
        public typealias RawValue = Int
        case top
        case bottom
        
        func layoutAttribute() -> NSLayoutConstraint.Attribute {
            switch self {
            case YAnchorEnumType.top:
                return NSLayoutConstraint.Attribute.top
            case YAnchorEnumType.bottom:
                return NSLayoutConstraint.Attribute.bottom
            }
        }
        
        func anchor(for view: UIView) -> NSLayoutYAxisAnchor {
            switch self {
            case YAnchorEnumType.top:
                return view.topAnchor
            case YAnchorEnumType.bottom:
                return view.bottomAnchor
            }
        }
        
        func anchor(for guide: UILayoutGuide) -> NSLayoutYAxisAnchor {
            switch self {
            case YAnchorEnumType.top:
                return guide.topAnchor
            case YAnchorEnumType.bottom:
                return guide.bottomAnchor
            }
        }
    }
    
    private enum XAnchorEnumType: Int {
        public typealias RawValue = Int
        case leading
        case trailing
        
        func layoutAttribute() -> NSLayoutConstraint.Attribute {
            switch self {
            case XAnchorEnumType.leading:
                return NSLayoutConstraint.Attribute.leading
            case XAnchorEnumType.trailing:
                return NSLayoutConstraint.Attribute.trailing
            }
        }
        
        func anchor(for view: UIView) -> NSLayoutXAxisAnchor {
            switch self {
            case XAnchorEnumType.leading:
                return view.leadingAnchor
            case XAnchorEnumType.trailing:
                return view.trailingAnchor
            }
        }
        
        func anchor(for guide: UILayoutGuide) -> NSLayoutXAxisAnchor {
            switch self {
            case XAnchorEnumType.leading:
                return guide.leadingAnchor
            case XAnchorEnumType.trailing:
                return guide.trailingAnchor
            }
        }
    }
    
    //MARK: - Public Methods
    
    @discardableResult func top(withView view: UIView, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000, toSafeArea safeArea: Bool = false) -> NSLayoutConstraint {
        guard safeArea else {
            return self.constraint(withItem: self, attribute: NSLayoutConstraint.Attribute.top, toItem: view, relation: relation, constant: constant, priority: priority)
        }
        return self.constraint(toView: view, withYAnchor: YAnchorEnumType.top, relation: relation, constant: constant, priority: priority)
    }
    
    @discardableResult func bottom(withView view: UIView, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000, toSafeArea safeArea: Bool = false) -> NSLayoutConstraint {
        guard safeArea else {
            return self.constraint(withItem: self, attribute: NSLayoutConstraint.Attribute.bottom, toItem: view, relation: relation, constant: constant, priority: priority)
        }
        return self.constraint(toView: view, withYAnchor: YAnchorEnumType.bottom, relation: relation, constant: constant, priority: priority)
    }
    
    @discardableResult func leading(withView view: UIView, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000, toSafeArea safeArea: Bool = false) -> NSLayoutConstraint {
        guard safeArea else {
            return self.constraint(withItem: self, attribute: NSLayoutConstraint.Attribute.leading, toItem: view, relation: relation, constant: constant, priority: priority)
        }
        return self.constraint(toView: view, withXAnchor: XAnchorEnumType.leading, relation: relation, constant: constant, priority: priority)
    }
    
    @discardableResult func trailing(withView view: UIView, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000, toSafeArea safeArea: Bool = false) -> NSLayoutConstraint {
        guard safeArea else {
            return self.constraint(withItem: self, attribute: NSLayoutConstraint.Attribute.trailing, toItem: view, relation: relation, constant: constant, priority: priority)
        }
        return self.constraint(toView: view, withXAnchor: XAnchorEnumType.trailing, relation: relation, constant: constant, priority: priority)
    }
    
    @discardableResult func width(constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: relation, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        self.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func height(constant: CGFloat = 0.0, multiplier: CGFloat = 1.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: relation, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        self.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func aspectRatio(from attribute: NSLayoutConstraint.Attribute = .height, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        
        let fromAttribute: NSLayoutConstraint.Attribute
        if (attribute != NSLayoutConstraint.Attribute.height && attribute != NSLayoutConstraint.Attribute.width) {
            fromAttribute = NSLayoutConstraint.Attribute.height
        }
        else { fromAttribute = attribute }
        
        let toAttribute: NSLayoutConstraint.Attribute
        if attribute == NSLayoutConstraint.Attribute.height { toAttribute = NSLayoutConstraint.Attribute.width }
        else { toAttribute = NSLayoutConstraint.Attribute.height }
        
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: fromAttribute, relatedBy: relation, toItem: self, attribute: toAttribute, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        self.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func relationalHeight(toView view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        return self.relational(attribute: NSLayoutConstraint.Attribute.height, toAttribute: NSLayoutConstraint.Attribute.height, toView: view, fromView: parent, multiplier: multiplier, constant: constant, relation: relation, priority: priority)
    }
    
    @discardableResult func relationalWidth(toView view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        return self.relational(attribute: NSLayoutConstraint.Attribute.width, toAttribute: NSLayoutConstraint.Attribute.width, toView: view, fromView: parent, multiplier: multiplier, constant: constant, relation: relation, priority: priority)
    }
    
    @discardableResult func relational(attribute: NSLayoutConstraint.Attribute, toAttribute otherAttribute: NSLayoutConstraint.Attribute, toView view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relation, toItem: view, attribute: otherAttribute, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        parent.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func centerX(withView view: UIView, fromView parent: UIView? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: relation, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        if let parentView: UIView = parent {
            parentView.addConstraint(constraint)
        }
        else {
            view.addConstraint(constraint)
        }
        return constraint
    }
    
    @discardableResult func centerY(withView view: UIView, fromView parent: UIView? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: relation, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        if let parentView: UIView = parent {
            parentView.addConstraint(constraint)
        }
        else {
            view.addConstraint(constraint)
        }
        return constraint
    }
    
    @discardableResult func top(toBottom view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: relation, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        parent.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func bottom(toTop view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: relation, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        parent.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func left(toRight view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.left, relatedBy: relation, toItem: view, attribute: NSLayoutConstraint.Attribute.right, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        parent.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func right(toLeft view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.right, relatedBy: relation, toItem: view, attribute: NSLayoutConstraint.Attribute.left, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        parent.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func top(toView view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: relation, toItem: view, attribute: NSLayoutConstraint.Attribute.top, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        parent.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func bottom(toView view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: relation, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        parent.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func leading(toView view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: relation, toItem: view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        parent.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult func trailing(toView view: UIView, fromView parent: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: relation, toItem: view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: multiplier, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        parent.addConstraint(constraint)
        return constraint
    }
    
    //MARK: - Private Methods
    
    private func constraint(withItem item: UIView, attribute: NSLayoutConstraint.Attribute, toItem otherItem: UIView, relation: NSLayoutConstraint.Relation, constant: CGFloat, priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: item, attribute: attribute, relatedBy: relation, toItem: otherItem, attribute: attribute, multiplier: 1.0, constant: constant)
        constraint.priority = UILayoutPriority(priority)
        otherItem.addConstraint(constraint)
        return constraint
    }
    
    private func constraint(toView view: UIView, withXAnchor xAnchor: XAnchorEnumType, relation: NSLayoutConstraint.Relation, constant: CGFloat, priority: Float = 1000) -> NSLayoutConstraint {
        return self.constraint(withGuide: view.safeAreaLayoutGuide, xAnchor: xAnchor, relation: relation, constant: constant, priority: priority)
    }
    
    private func constraint(toView view: UIView, withYAnchor yAnchor: YAnchorEnumType, relation: NSLayoutConstraint.Relation, constant: CGFloat, priority: Float = 1000) -> NSLayoutConstraint {
        return self.constraint(withGuide: view.safeAreaLayoutGuide, yAnchor: yAnchor, relation: relation, constant: constant, priority: priority)
    }
    
    private func constraint(withGuide guide: UILayoutGuide, xAnchor: XAnchorEnumType, relation: NSLayoutConstraint.Relation, constant: CGFloat, priority: Float = 1000) -> NSLayoutConstraint {
        let xAnchorLayout: NSLayoutXAxisAnchor = xAnchor.anchor(for: self)
        let xAnchorGuideLayout: NSLayoutXAxisAnchor = xAnchor.anchor(for: guide)
        let constraint: NSLayoutConstraint = xAnchorLayout.constraint(to: xAnchorGuideLayout, constant: constant, relation: relation)
        constraint.isActive = true
        constraint.priority = UILayoutPriority(priority)
        return constraint
    }
    
    private func constraint(withGuide guide: UILayoutGuide, yAnchor: YAnchorEnumType, relation: NSLayoutConstraint.Relation, constant: CGFloat, priority: Float = 1000) -> NSLayoutConstraint {
        let yAnchorLayout: NSLayoutYAxisAnchor = yAnchor.anchor(for: self)
        let yAnchorGuideLayout: NSLayoutYAxisAnchor = yAnchor.anchor(for: guide)
        let constraint: NSLayoutConstraint = yAnchorLayout.constraint(to: yAnchorGuideLayout, constant: constant, relation: relation)
        constraint.isActive = true
        constraint.priority = UILayoutPriority(priority)
        return constraint
    }
}

//MARK: - NSLayoutXAxisAnchor

public extension NSLayoutXAxisAnchor {
    func constraint(to anchor: NSLayoutXAxisAnchor, constant c: CGFloat, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal) -> NSLayoutConstraint {
        switch relation {
        case NSLayoutConstraint.Relation.equal:
            return self.constraint(equalTo: anchor, constant: c)
        case NSLayoutConstraint.Relation.greaterThanOrEqual:
            return self.constraint(greaterThanOrEqualTo: anchor, constant: c)
        case NSLayoutConstraint.Relation.lessThanOrEqual:
            return self.constraint(lessThanOrEqualTo: anchor, constant: c)
        default:
            return self.constraint(equalTo: anchor, constant: c)
        }
    }
}

//MARK: - NSLayoutYAxisAnchor

public extension NSLayoutYAxisAnchor {
    func constraint(to anchor: NSLayoutYAxisAnchor, constant c: CGFloat, relation: NSLayoutConstraint.Relation = NSLayoutConstraint.Relation.equal) -> NSLayoutConstraint {
        switch relation {
        case NSLayoutConstraint.Relation.equal:
            return self.constraint(equalTo: anchor, constant: c)
        case NSLayoutConstraint.Relation.greaterThanOrEqual:
            return self.constraint(greaterThanOrEqualTo: anchor, constant: c)
        case NSLayoutConstraint.Relation.lessThanOrEqual:
            return self.constraint(lessThanOrEqualTo: anchor, constant: c)
        default:
            return self.constraint(equalTo: anchor, constant: c)
        }
    }
}
