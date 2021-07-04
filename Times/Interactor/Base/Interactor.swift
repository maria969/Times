//
//  Interactor.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

//MARK: - InteractorInput

public class Interactor: InteractorInterface {
    
    public typealias ExecuteBlock<T: Interactor> = (_ interactor: T) -> Void
    public typealias Completion = () -> Void
    
    //MARK: - Public Properties
    
    public var workingQueue: DispatchQueue {
        return self.operationQueue
    }

    //MARK: - Private Poperties
    
    private let operationQueue: DispatchQueue = DispatchQueue(label: "com.mariaherrerovaras.times.Interactor")
    private var invocationQueue: DispatchQueue = DispatchQueue.main
    
    //MARK: - Intializers
    
    public init() {
    }
    
    //MARK: - Public Methods
    
    public func assignCallback(_ callback: Queueable) {
        self.invocationQueue = callback.workingQueue
    }
    
    //MARK: - Internal Methods
    
    func execute<K: Interactor>(_ work: @escaping ExecuteBlock<K>) {
        guard let interactor: K = self as? K else { fatalError() }
        self.operationQueue.async { work(interactor) }
    }
    
    func finish(_ work: @escaping Interactor.Completion) {
        self.invocationQueue.async { work() }
    }
}
