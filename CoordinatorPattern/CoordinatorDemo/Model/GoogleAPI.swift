//
//  GoogleAPI.swift
//  CoordinatorDemo
//
//  Created by Avinash on 10/10/19.
//  Copyright © 2019 annpriya. All rights reserved.
//

import Foundation

public struct ResultsData {
    var results: [Results] = [Results]()
}

public struct Results {
    let formattedAddress: String?
    let name: String?
    let geometry: Geometry?
}

public struct Geometry {
    let location: Location?
}

public struct Location {
    let lat: Double?
    let lng: Double?
}

extension ResultsData {
    public init(json: JSONDictionary) throws {
        let resultsJSON = json["results"] as? [JSONDictionary]
        try resultsJSON?.forEach { result in
            let resultValue = try Results(json: result)
            results.append(resultValue)
        }
    }
}

extension Results {
    public init(json: JSONDictionary) throws {
        formattedAddress = json["formattedAddress"] as? String
        name = json["name"] as? String
        geometry = try Geometry(json: json["geometry"] as! JSONDictionary)
    }

}

extension Geometry {
    public init(json: JSONDictionary) throws {
       location = try Location(json: json["location"] as! JSONDictionary)
    }
}

extension Location {
    public init(json: JSONDictionary) throws {
        lat = json["formattedAddress"] as? Double
        lng = json["name"] as? Double
    }
}
