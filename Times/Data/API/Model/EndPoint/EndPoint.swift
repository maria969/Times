//
//  EndPoint.swift
//  Times
//
//  Created by Maria Herrero Varas on 04/07/2021.
//

import Foundation
import Alamofire
import Resolver

public final class EndPoint<T> {
    
    public typealias Path = String
    public typealias Parameters = [String: Any]?
    public typealias Headers = [String: String]?
    
    enum Encoding: Int {
        case url
    }
    
    //MARK: - Public Properties
    
    public private(set) var method: Alamofire.HTTPMethod = Alamofire.HTTPMethod.post
    public private(set) var path: EndPoint.Path = ""
    
    public private(set) var parameters: EndPoint.Parameters = nil
    
    public var headers: EndPoint.Headers {
        let environment: EnvironmentInterface = self.environmentManager.environment()
        var environmentHeaders: [String: String] = environment.headers()
        
        guard let headers: [String: String] = self._headers else { return environmentHeaders }
        environmentHeaders.add(items: headers)
        return environmentHeaders
    }
    
    public private(set) var encoding: ParameterEncoding
    
    public var resultType: T.Type {
        return T.self
    }
    
    public var url: URL {
        let environment: EnvironmentInterface = self.environmentManager.environment()
        let baseURL: URL = environment.serverURL().baseURL
        
        return self.path.buildURL(from: baseURL)
    }
    
    public private(set) var queue: DispatchQueue = DispatchQueue.main
    
    //MARK: - Private Properties
    
    private var _parameters: EndPoint.Parameters = nil

    private var _headers: EndPoint.Headers = nil
    private var httpHeaders: HTTPHeaders? {
        guard let headers: [String: String] = self.headers else { return nil }
        return HTTPHeaders(headers)
    }
    
    private var _encoding: Encoding = Encoding.url
    private let environmentManager: EnvironmentManagerInterface
    
    //MARK: - Initializers
    
    private init() {
        self.encoding = self._encoding.encoding(for: self.method)
        self.environmentManager = Resolver.resolve()
    }
    
    //MARK: - Public Methods
    
    public func request(withSession session: Session) -> DataRequest {
        let request: DataRequest = session.request(self.url,
                                                   method: self.method,
                                                   parameters: self.parameters,
                                                   encoding: self.encoding,
                                                   headers: self.httpHeaders)
        
        return request
    }
    
    //MARK: - Endpoint Builder

    class Builder {
        
        public typealias QueryParamaters<E: Encodable> = E
        
        //MARK: - Private Properties
        
        private var endpoint: EndPoint<T>
        
        //MARK: - Initializers
        
        public required init() {
            self.endpoint = EndPoint<T>()
        }
        
        //MARK: - Public Methods
        
        public func method(_ method: Alamofire.HTTPMethod) -> Builder {
            self.endpoint.method = method
            return self
        }
        
        public func path(_ path: APIPath) -> Builder {
            self.endpoint.path = Path.path(for: path)
            return self
        }
        
        public func path(_ path: EndPoint.Path) -> Builder {
            self.endpoint.path = path
            return self
        }
        
        public func parameters(_ parameters: EndPoint.Parameters) -> Builder {
            self.endpoint.parameters = parameters
            self.endpoint._encoding = Encoding.url
            return self
        }
        
        public func parameters<E: Encodable>(_ parameters: QueryParamaters<E>) -> Builder {
            let queryParameters: Parameters = parameters.asURLEncodedParameters()
            return self.parameters(queryParameters)
        }
        
        public func headers(_ headers: EndPoint.Headers) -> Builder {
            self.endpoint._headers = headers
            return self
        }
        
        public func queue(_ queue: DispatchQueue) -> Builder {
            self.endpoint.queue = queue
            return self
        }
        
        public func build() -> EndPoint<T> {
            self.endpoint.encoding = self.endpoint._encoding.encoding(for: self.endpoint.method)
            return self.endpoint
        }
    }
}

//MARK: - Path Methods

private extension EndPoint.Path {
    
    //MARK: - Private Methods
    
    private var isAbsolute: Bool {
        return self.range(of: ApiConstants.Identifiers.HTTP) != nil
    }
    
    //MARK: - Public Methods
    
    func buildURL(from baseURL: URL) -> URL {
        guard self.isAbsolute else {
            return baseURL.appendingPathComponent(self)
        }
        guard let url: URL = URL(string: self) else {
            return baseURL
        }
        return url
    }
    
    static func path(for apiPath: APIPath) -> Self {
        return apiPath.path
    }
}


//MARK: - Encoding

private extension EndPoint.Encoding {
    
    //MARK: - Public Methods
    
    func encoding(for method: Alamofire.HTTPMethod) -> ParameterEncoding {
        switch self {
        case EndPoint.Encoding.url:
            return Self.parameterEncoding(forMethod: method)
        }
    }
    
    //MARK: - Private Methods
    
    private static func parameterEncoding(forMethod method: Alamofire.HTTPMethod) -> ParameterEncoding {
        switch method {
        case Alamofire.HTTPMethod.post:
            return URLEncoding(destination: URLEncoding.Destination.httpBody,
                               arrayEncoding: URLEncoding.ArrayEncoding.noBrackets,
                               boolEncoding: URLEncoding.BoolEncoding.literal)
        default:
            return URLEncoding.default
        }
    }
}
