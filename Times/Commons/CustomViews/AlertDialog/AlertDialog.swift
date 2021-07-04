//
//  AlertDialog.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation
import UIKit

public class AlertDialog: UIViewController {
    
    public typealias GeneralCompletion = () -> Void
    
    //MARK: - Properties
    
    private var containerView: UIView!
    private var titleLabel: UILabel?
    private var messageLabel: UILabel!
    private var firstButton: Button!
    
    private var titleString: String?
    private var message: String
    private var firstButtonTitle: String
    private var firstButtonAction: GeneralCompletion?

    
    //MARK: - Initializers
    
    required public init(withTitle title: String?,
                  andMessage message: String,
                  buttonText: String,
                  buttonAction action: AlertDialog.GeneralCompletion?) {
        
        self.titleString = title
        self.message = message
        self.firstButtonTitle = buttonText
        self.firstButtonAction = action
        
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        self.configureView()
    }
    
    required convenience public init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    //MARK: - Layout
    
    private func configureView() {
        self.configureContainer()
        self.configureTitle()
        self.configureMessage()
        self.configureFirstButton()
    }
    
    private func configureContainer() {
        self.containerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width-40, height: 200))
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.containerView)
        self.containerView.width(constant: UIScreen.main.bounds.size.width-40.0)
        self.containerView.centerX(withView: self.view)
        self.containerView.centerY(withView: self.view)
        self.containerView.layer.cornerRadius = 3.0
        self.containerView.backgroundColor = .white
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    private func configureTitle() {
        guard let title: String = self.titleString else { return }
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 17))
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(titleLabel)
        titleLabel.top(withView: self.containerView, constant: 20.0)
        titleLabel.leading(withView: self.containerView, constant: 20.0)
        titleLabel.trailing(withView: self.containerView, constant: -20.0)
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 21.0, weight: .semibold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.text = title
        self.titleLabel = titleLabel
    }
    
    private func configureMessage() {
        self.messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 17))
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(self.messageLabel)
        if let titleLabel: UILabel = self.titleLabel {
            self.messageLabel.top(toBottom: titleLabel, fromView: self.containerView, constant: 10.0)
        }
        else { self.messageLabel.top(withView: self.containerView, constant: 20.0) }
        self.messageLabel.leading(withView: self.containerView, constant: 20.0)
        self.messageLabel.trailing(withView: self.containerView, constant: -20.0)
        self.messageLabel.numberOfLines = 0
        self.messageLabel.font = UIFont.systemFont(ofSize: 17.0)
        self.messageLabel.textAlignment = .left
        self.messageLabel.textColor = .black
        self.messageLabel.text = self.message
    }
    
    private func configureFirstButton() {
        self.firstButton = Button(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        self.firstButton.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(self.firstButton)
        self.firstButton.top(toBottom: self.messageLabel, fromView: self.containerView, constant: 15.0)
        self.firstButton.bottom(withView: self.containerView, constant: -20.0)
        self.firstButton.trailing(withView: self.containerView, constant: -20.0)
        self.firstButton.height(constant: 30.0)
        self.firstButton.textButton(with: self.firstButtonTitle, textColor: UIColor.systemBlue, font: UIFont.systemFont(ofSize: 15.0))
        self.firstButton.addTarget(self, action: #selector(tapFirstButton), for: .touchUpInside)
    }
    
    //MARK: - Actions
    
    @objc func tapFirstButton() {
        self.dismiss(animated: true) {
            self.firstButtonAction
        }
    }
}

//MARK: - AlertDialogInterface

extension AlertDialog: AlertDialogInterface {
    public func show(fromView view: UIViewController) {
        view.present(self, animated: true, completion: nil)
    }
}
