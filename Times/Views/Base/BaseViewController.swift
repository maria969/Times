//
//  BaseViewController.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import UIKit

public class BaseViewController: UIViewController {
    
    public typealias GeneralCompletion = () -> Void
    
    //MARK: - Private Properties
    
    open var window: UIWindow? {
        return UIWindow.main
    }
    
    //MARK: - Private Properties
    
    private lazy var loadingIndicator: LoadingIndicator = {
        let message: String = "times.general.app.title.loading".localized()
        let loadingIndicator: LoadingIndicator = LoadingIndicator(message: message, viewController: self)
        return loadingIndicator
    }()
    
    //MARK: - Intializers
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.modalPresentationStyle = UIModalPresentationStyle.fullScreen
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewReady = true
    }
    
    //MARK: - Layout
    
    private func configureView() {
    }
}

//MARK: - BaseViewControllerInterface

extension BaseViewController: BaseViewControllerInterface {
    public func showLoading() {
        self.loadingIndicator.start()
    }
    
    public func hideLoading() {
        self.loadingIndicator.stop()
    }
}

//MARK: - LoadableView

extension BaseViewController: LoadableView {}
