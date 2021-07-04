//
//  AppDelegate.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import UIKit
import Resolver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Private Properties
    
    public var window: UIWindow?
    
    //MARK: - Public Methods

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.configureEntryPoint(withLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    //MARK: - Private Methods
    
    private func configureEntryPoint(withLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let demoViewController: SearchViewControllerInterface = Resolver.resolve()
        self.window?.rootViewController = NavigationController(rootViewController: demoViewController.viewController)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
    }
}
