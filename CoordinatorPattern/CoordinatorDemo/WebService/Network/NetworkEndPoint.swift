//
//  NetworkEndPoint.swift
//  CoordinatorDemo
//
//  Created by Avinash on 10/10/19.
//  Copyright © 2019 annpriya. All rights reserved.
//

import Foundation

private enum NetworkEndPoint: String {
    case prod
    case staging
    case qa
    case develop
    
    var apiKey: String {
        switch self {
        case .prod:
            return "AIzaSyDtYvnVdeEPcO4-cEOGePbfOl7qMVKAYrU"
        case .staging:
            return "AIzaSyDtYvnVdeEPcO4-cEOGePbfOl7qMVKAYrU"
        case .qa:
            return "AIzaSyDtYvnVdeEPcO4-cEOGePbfOl7qMVKAYrU"
        case .develop:
            return "AIzaSyDtYvnVdeEPcO4-cEOGePbfOl7qMVKAYrU"
        }
    }
    
    var apiURL: String {
        switch self {
        case .prod:
            return "https://maps.googleapis.com/maps/api/place/textsearch/json?"
        case .staging:
            return "https://maps.googleapis.com/maps/api/place/textsearch/json?"
        case .qa:
            return "https://maps.googleapis.com/maps/api/place/textsearch/json?"
        case .develop:
            return "https://maps.googleapis.com/maps/api/place/textsearch/json?"
        }
    }
}

public struct AppConfiguration {
    internal var apiURL: URL
    internal var apiKey: String
    private let enviornment: NetworkEndPoint
    
    public static var `default`: AppConfiguration = {
        #if PRODUCTION
        let enviorment = NetworkEndPoint.prod
        #elseif QA
        let enviorment = NetworkEndPoint.qa
        #elseif STAGING
        let enviorment = NetworkEndPoint.staging
        #else
        let enviorment = NetworkEndPoint.develop
        #endif
        
        var apiUrlString = enviorment.apiURL
        let apiUrl = URL(string: apiUrlString)!
        return AppConfiguration(apiURL: apiUrl, apiKey: enviorment.apiKey, enviornment: enviorment)
    }()
}
