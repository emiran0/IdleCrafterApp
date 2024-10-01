//  Created by Emiran Kartal on 1.10.2024.
//
// Models/User.swift

import Foundation

struct User: Codable {
    let username: String
    let email: String
    let gold: Double
    let energy: Double

    enum CodingKeys: String, CodingKey {
        case username = "Username"
        case email = "Email"
        case gold = "Gold"
        case energy = "Energy"
    }
}

struct TokenResponse: Codable {
    let accessToken: String
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
