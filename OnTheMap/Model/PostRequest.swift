//
//  PostRequest.swift
//  OnTheMap
//
//  Created by nF ™ on 12/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import Foundation
struct PostRequest: Codable {
    let uniqueKey, firstName, lastName, mapString: String
    let mediaURL: String
    let latitude, longitude: Double
}
