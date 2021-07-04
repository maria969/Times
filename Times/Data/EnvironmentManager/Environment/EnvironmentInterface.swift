//
//  EnvironmentInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public protocol EnvironmentInterface: AnyObject {
    func environmentType() -> EnvironmentType
    
    func serverURL() -> ServerURL
    func timeout() -> Double
    func headers() -> [String: String]
}
