//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by nF ™ on 14/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import Foundation
struct SessionFailureResponse: Codable {
    let status: Int
    let error: String
}
