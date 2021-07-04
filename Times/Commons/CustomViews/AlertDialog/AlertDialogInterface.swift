//
//  AlertDialogInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation
import UIKit

protocol AlertDialogInterface: AnyObject {
    init(withTitle title: String?,
         andMessage message: String,
         buttonText: String,
         buttonAction action: AlertDialog.GeneralCompletion?)
    
    func show(fromView view: UIViewController)
}
