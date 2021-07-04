//
//  ApiTrustManager.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Alamofire

public class ApiTrustManager: ServerTrustManager {
    
    //MARK: - Initializers
    
    public init() {
        super.init(allHostsMustBeEvaluated: true, evaluators: [:])
    }
    
    //MARK: - Public Methods
    
    public override func serverTrustEvaluator(forHost host: String) throws -> ServerTrustEvaluating? {
        return DisabledTrustEvaluator()
    }
}
