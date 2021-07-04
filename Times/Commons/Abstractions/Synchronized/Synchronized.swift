//
//  Synchronized.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation

public class Synchronized<T> {
    
    public typealias ReaderBlock<K> = (T) throws -> K
    public typealias WriterBlock = (inout T) -> Void
    
    //MARK: - Public Properties
    
    public var value: T {
        get { return self.queue.sync { self._value } }
        set {
            self.queue.async(flags: .barrier) {
                self._value = newValue
            }
        }
    }
    
    //MARK: - Private Properties
    
    private var _value: T
    private let queue: DispatchQueue
    
    //MARK: - Initializers
    
    public required init(_ value: T) {
        self._value = value
        self.queue = DispatchQueue(label: "com.mariaherrerovaras.times.Synchronized", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent)
    }
    
    //MARK: - Public Methods
    
    public func reader<K>(_ block: ReaderBlock<K>) rethrows -> K {
        return try self.queue.sync { try block(self._value) }
    }
    
    public func writer(_ block: @escaping WriterBlock) {
        self.queue.sync {
            block(&self._value)
        }
    }
    
    public func asyncWriter(_ block: @escaping WriterBlock) {
        self.queue.async(flags: DispatchWorkItemFlags.barrier) {
            block(&self._value)
        }
    }
}
