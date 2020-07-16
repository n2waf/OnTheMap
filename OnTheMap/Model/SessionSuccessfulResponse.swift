//
//  SessionSuccessfulResponse.swift
//  OnTheMap
//
//  Created by nF ™ on 14/07/2020.
//  Copyright © 2020 nF ™. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct SessionSuccessfulResponse: Codable {
    let account: Account
    let session: Session
}

// MARK: - Account
struct Account: Codable {
    let registered: Bool
    let key: String
}

// MARK: - Session
struct Session: Codable {
    let id, expiration: String
}
