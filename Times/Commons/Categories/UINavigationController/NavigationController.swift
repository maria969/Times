//
//  NavigationController.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    
    //MARK: - Private Properties
    
    private var isPushAnimation: Bool = false
    private var isPopping: Bool = false
    private weak var interactivePopDelegate: InteractivePopGestureInterface?
    
    //MARK: - Initializers
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.delegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.delegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
    }
    
    required init?(viewControllers: [UIViewController]) {
        guard let rootViewController: UIViewController = viewControllers.object(atIndex: 0) else { return nil }
        let otherViewControllers: [UIViewController] = Array(viewControllers.dropFirst())
        super.init(rootViewController: rootViewController)
        self.viewControllers.append(contentsOf: otherViewControllers)
        self.delegate = self
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.interactivePopDelegate = self.viewControllers.last
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    deinit {
        self.delegate = nil
        self.interactivePopDelegate = nil
        self.interactivePopGestureRecognizer?.delegate = nil
    }
    
    //MARK: - Public Methods
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.isPushAnimation = true
        self.interactivePopDelegate = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    @discardableResult override func popViewController(animated: Bool) -> UIViewController? {
        self.isPopping = true
        return super.popViewController(animated: animated)
    }
    
    @discardableResult override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        self.interactivePopDelegate = viewController
        return super.popToViewController(viewController, animated: animated)
    }
    
    //MARK: - Private Methods
    
    private func interactivePopViewController(_ navigationController: NavigationController, viewController: UIViewController?) {
        guard self.interactivePopGestureRecognizer?.state == UIGestureRecognizer.State.began else {
            self.isPopping = false
            self.interactivePopDelegate?.navigationControllerWillPopBack()
            self.interactivePopDelegate = viewController
            return
        }
        
        let coordinator: UIViewControllerTransitionCoordinator? = viewController?.transitionCoordinator
        coordinator?.notifyWhenInteractionChanges { [weak navigationController, viewController] (context) in
            if context.isCancelled {
                navigationController?.isPopping = false
            }
            else {
                navigationController?.isPopping = false
                navigationController?.interactivePopDelegate?.navigationControllerWillPopBack()
                navigationController?.interactivePopDelegate = viewController
            }
        }
    }
}

//MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let currentNavigationController: NavigationController = navigationController as? NavigationController else { return }
        currentNavigationController.isPushAnimation = false
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let currentNavigationController: NavigationController = navigationController as? NavigationController,
            currentNavigationController.isPopping else { return }
        self.interactivePopViewController(currentNavigationController, viewController: currentNavigationController.topViewController)
    }
}

//MARK: - UIGestureRecognizerDelegate

extension NavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == self.interactivePopGestureRecognizer else { return true }
        let allowedPopGesture: Bool = self.viewControllers.count > 1 && !self.isPushAnimation
        guard allowedPopGesture else { return false }
        return self.interactivePopDelegate?.isInteractivePopGestureEnabled() ?? false
    }
}
