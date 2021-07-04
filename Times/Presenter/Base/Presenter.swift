//
//  Presenter.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//  
//

import Foundation

//MARK: - PresenterInterface

public class Presenter<View: ViewControllerRepresentable>: PresenterInterface {
    
    //MARK: - Public Properties
    
    public var workingQueue: DispatchQueue {
        return self.queue
    }
    
    public var view: View? {
        return self._view
    }
    
    //MARK: - Private Properties
    
    private var queue: DispatchQueue = DispatchQueue.main
    private weak var _view: View?
    
    //MARK: - Initializers
    
    public init() {
    }
    
    //MARK: - Public Methods
    
    public func assingView<T: ViewControllerRepresentable>(_ view: T) {
        self._view = view as? View
    }
}
