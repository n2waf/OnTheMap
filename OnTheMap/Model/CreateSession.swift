//
//  CreateSession.swift
//  OnTheMap
//
//  Created by nF ™ on 14/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct CreateSession: Codable {
    let udacity: Udacity
}

// MARK: - Udacity
struct Udacity: Codable {
    let username, password: String
}
