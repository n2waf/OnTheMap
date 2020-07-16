//
//  PostResponse.swift
//  OnTheMap
//
//  Created by nF ™ on 12/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct PostResponse: Codable {
    let objectID, createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case objectID = "objectId"
        case createdAt
    }
}
