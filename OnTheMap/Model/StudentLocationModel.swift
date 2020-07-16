//
//  File.swift
//  OnTheMap
//
//  Created by nF ™ on 12/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct StudentLocationModel: Codable {
    var results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let firstName, lastName: String
    let longitude, latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey, objectID, createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName, longitude, latitude, mapString, mediaURL, uniqueKey
        case objectID = "objectId"
        case createdAt, updatedAt
    }
}
