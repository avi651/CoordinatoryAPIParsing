//
//  GoogleAPI+Resource.swift
//  CoordinatorDemo
//
//  Created by Avinash on 10/10/19.
//  Copyright © 2019 annpriya. All rights reserved.
//

import Foundation

extension ResultsData {
    
    internal typealias result = ((_ resultsData: ResultsData, _ statusCode: HTTPStatusCode) -> Void)
    
    public enum EndPoints: String {
        #if PRODUCTION
        case root = "p1"
        #elseif STAGING
        case root = "p2"
        #elseif QA
        case root = "p2"
        #else
        case root = "p2"
        #endif
    }
    
    func fetch(params: [String: Any] = [:], queryValue: String, location: String, radius: Int, completionHandler: @escaping(result)) {
        
        /// URLQueryItem - is included in api as part of URLComponent. Its normally used in case of get type api in which params is appended in URL.
        var query: [URLQueryItem] = []
        query.append(URLQueryItem(name:  "query", value: ("\(queryValue)") + "&"))
        query.append(URLQueryItem(name:  "location", value: "25.5941,85.137&"))
        query.append(URLQueryItem(name:  "radius", value: ("\(radius)") + "&"))
        query.append(URLQueryItem(name:  "key", value: ("\(AppConfiguration.default.apiKey)") + "&"))

        let requestURL = "\(AppConfiguration.default.apiURL)" + "\(query)"
        
        NetworkManager().apiRequest(.get, requestURL, [:], [:]) {  (data, statusCode)   in
            do {
                guard let data = data else { return }
                let jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                let resultsData = try ResultsData(json: jsonResult as! JSONDictionary)
                return completionHandler(resultsData, statusCode ?? HTTPStatusCode(value: 0))
            } catch {
                 print("Fail")
            }
        }
    }
}
