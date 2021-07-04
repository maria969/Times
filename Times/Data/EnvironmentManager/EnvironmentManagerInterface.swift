//
//  EnvironmentManagerInterface.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public protocol EnvironmentManagerInterface: AnyObject {
    func environmentType() -> EnvironmentType
    func environment() -> EnvironmentInterface
}
