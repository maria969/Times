//
//  LoadingView.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

open class LoadingView: UIView {
    
    //MARK: - Public Properties
    
    public var isLoading: Bool {
        get { return self.loading.reader { $0 } }
        set { self.loading.writer { $0 = newValue } }
    }
    
    public var viewController: UIViewController? {
        return self._viewController
    }
    
    //MARK: - Private Properties
    
    private weak var _viewController: UIViewController?
    private var loading: Synchronized<Bool> = Synchronized<Bool>(false)
    private var observer: NSKeyValueObservation?
    
    //MARK: - Initializers
    
    public required init(frame: CGRect, viewController: Loading?) {
        super.init(frame: frame)
        self._viewController = viewController
        self.configureView()
    }
    
    @available(*, unavailable, message: "This initializer is not accessible. Use init(frame: CGRect, viewController: Loading?) instead")
    public override init(frame: CGRect) {
        fatalError("This initializer is not accessible. Use init(frame: CGRect, viewController: Loading?) instead")
    }
    
    @available(*, unavailable, message: "This initializer is not accessible. Use init(frame: CGRect, viewController: Loading?) instead")
    public required init?(coder aDecoder: NSCoder) {
        assert(false, "This initializer is not accessible. Use init(frame: CGRect, viewController: Loading?) instead")
        return nil
    }
    
    deinit {
        self.observer?.invalidate()
        self.observer = nil
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.configureObservers()
    }
    
    private func configureObservers() {
        self.observer = self.viewController?.observe(\.isViewReady, options: [NSKeyValueObservingOptions.new]) { [weak self] (object, value) in
            self?.viewControllerDidLoad(value.newValue)
        }
    }
    
    //MARK: - Private Methods
    
    private func removeObservers() {
        self.observer?.invalidate()
        self.observer = nil
    }
    
    //MARK: - Events
    
    private func viewControllerDidLoad(_ isViewLoaded: Bool?) {
        guard isViewLoaded == true else { return }
        if self.isLoading { self.superview?.bringSubviewToFront(self) }
        self.removeObservers()
    }
}

//MARK: - LoadingViewInterface

extension LoadingView: LoadingViewInterface {}
