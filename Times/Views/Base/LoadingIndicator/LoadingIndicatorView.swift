//
//  LoadingIndicatorView.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

public class LoadingIndicator: LoadingView {
    
    public typealias Origin = LoadableView & Loading
    
    //MARK: - Private Properties
    
    private var activityIndicator: UIActivityIndicatorView = {
        let view: UIActivityIndicatorView = UIActivityIndicatorView.whiteLarge
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var messageLabel: UILabel = {
        let label: UILabel = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19.0)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        return label
    }()
    
    private var message: String {
        get { return self.messageLabel.text ?? "" }
        set { self.messageLabel.text = newValue }
    }
    
    private weak var origin: LoadingIndicator.Origin?
    
    //MARK: - Initializers
    
    required public init(message: String, viewController: LoadingIndicator.Origin?) {
        let bounds: CGRect = UIScreen.main.bounds
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.height), viewController: viewController)
        self.configureView()
        self.message = message
        self.origin = viewController
    }
    
    @available(*, unavailable, message: "This initializer is not accessible. Use init(message: String, viewController: MDLoading?) instead")
    public required init(frame: CGRect, viewController: Loading?) {
        super.init(frame: frame, viewController: viewController)
        assert(false, "This initializer is not accessible. Use init(message: String, viewController: MDLoading?) instead")
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.66)
        self.isHidden = true
        self.configureActivityIndicator()
        self.configureMessageLabel()
    }
    
    private func configureActivityIndicator() {
        self.addSubview(self.activityIndicator)
        self.activityIndicator.centerX(withView: self)
        self.activityIndicator.centerY(withView: self, constant: -20.0)
    }
    
    private func configureMessageLabel() {
        self.addSubview(self.messageLabel)
        self.messageLabel.top(toBottom: self.activityIndicator, fromView: self, constant: 20.0)
        self.messageLabel.leading(withView: self, constant: 18.0)
        self.messageLabel.trailing(withView: self, constant: -18.0)
    }
    
    private func addIndicator(in view: UIViewController? = nil) -> Bool {
        self.isLoading = true
        if let viewController: UIViewController = view { return self.add(to: viewController.view) }
        else if let window: UIWindow = self.origin?.window { return self.add(to: window) }
        else { return self.add(to: UIWindow.main) }
    }
    
    private func removeIndicator(in view: UIViewController? = nil) {
        if let viewController: UIViewController = view { self.remove(in: viewController.view) }
        else if let window: UIWindow = self.origin?.window { self.remove(in: window) }
        else { self.remove(in: UIWindow.main) }
        self.isLoading = false
    }
    
    private func add(to view: UIView?) -> Bool {
        guard let currentView: UIView = view else { return false }
        self.removeAllIndicators(from: currentView)
        currentView.addSubview(self)
        currentView.bringSubviewToFront(self)
        self.isHidden = false
        return true
    }
    
    private func remove(in view: UIView?) {
        self.isHidden = true
        guard let currentView: UIView = view else { return }
        currentView.sendSubviewToBack(self)
        self.removeFromSuperview()
    }
    
    private func startLoading() {
        self.activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    private func removeAllIndicators(from view: UIView) {
        for subview in view.subviews {
            guard subview is LoadingIndicator else { continue }
            view.sendSubviewToBack(subview)
            subview.removeFromSuperview()
        }
    }
}

//MARK: - LoadingIndicatorInterface

extension LoadingIndicator: LoadingIndicatorInterface {
    public func configure(message: String) {
        self.message = message
    }
    
    public func start() {
        guard self.addIndicator() else { return }
        self.startLoading()
    }
    
    public func stop() {
        self.stopLoading()
        self.removeIndicator()
    }
    
    public func start(withView view: UIViewController) {
        guard self.addIndicator(in: view) else { return }
        self.startLoading()
    }
    
    public func stop(withView view: UIViewController) {
        self.stopLoading()
        self.removeIndicator(in: view)
    }
}
