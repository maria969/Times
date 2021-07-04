//
//  Queueable.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public protocol Queueable: AnyObject {
    var workingQueue: DispatchQueue { get }
}
