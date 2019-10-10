//
//  Network.swift
//  CoordinatorDemo
//
//  Created by Avinash on 10/10/19.
//  Copyright © 2019 annpriya. All rights reserved.
//

import Foundation
import UIKit

public enum HTTPStatusCode: Int {
    case success = 200
    case unreachable = -1009
    case notFound
    case noService
    case malformedContent
    case clientError
    
    public init(value: Int) {
        switch value {
        case 404: self = .malformedContent
        case 200...299: self = .success
        case 400...499: self = .clientError
        case 599: self = .malformedContent
        case -1008 ... -1001: self = .noService
        default: self = .unreachable
        }
    }
}

public typealias NetworkRouterCompletion = (_ data: Data?, _ statusCode: HTTPStatusCode?) -> ()

protocol NetworkRouter: class {
    func apiRequest(_ method: HTTPMethod, _ apiURL: String, _ parameters: [String: Any], _ headers: [String: String], completion: @escaping NetworkRouterCompletion)
}

class NetworkManager: NetworkRouter {
    
    public func apiRequest(_ method: HTTPMethod, _ apiURL: String, _ parameters: [String: Any], _ headers: [String: String], completion: @escaping NetworkRouterCompletion) {
        
        /// Create a default configuration
        let defaultSessionConfiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: defaultSessionConfiguration)
        
        /// Setup the request with URL
        let urlRequest = createURLRequest(method: method, apiURL: apiURL, parameters: parameters, headers: headers)
        
        // Create dataTask
        defaultSession.dataTask(with: urlRequest) { (data, response, error) in
            
            
            // We still pass back the status code whether we use the cache or not
            let validStatusCode = (response as? HTTPURLResponse)?.statusCode ?? (error?._code ?? HTTPStatusCode.unreachable.rawValue)
            
            // notFound implies intentionally removed content, so remove from the cache and return the error
            if HTTPStatusCode(value: validStatusCode) == .notFound {
                URLCache.shared.removeCachedResponse(for: urlRequest)
                completion(nil, HTTPStatusCode(value: validStatusCode))
                return
            }
            
            if let _ = error {
                // We have an error, so use our cached response if we have one, otherwise return failure
                guard let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) else {
                    completion(nil, HTTPStatusCode(value: validStatusCode))
                    return
                }
                completion(cachedResponse.data, HTTPStatusCode(value: validStatusCode))
            } else {
                completion(data!, HTTPStatusCode(value: validStatusCode))
            }
        }.resume()
    }
    
    private func createURLRequest(method: HTTPMethod, apiURL: String?, parameters: [String: Any]?, headers: [String: String]) -> URLRequest {
        
        guard let url = apiURL else { fatalError() }
        
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let params = parameters {
            let postData = (try? JSONSerialization.data(withJSONObject: params, options: []))
            request.httpBody = postData
        }
        return request
    }
}



