//
//  BaseViewControllerInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public protocol BaseViewControllerInterface: ViewControllerRepresentable {
    func showError(_ error: ErrorEntity, completion: BaseViewController.GeneralCompletion?)
    
    func showLoading()
    func hideLoading()
}
