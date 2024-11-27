//  TrialApp
//
//  Created by Emiran Kartal on 2.10.2024.
//
// Models/UserProfile.swift

import Foundation

struct UserProfile: Codable {
    let username: String
    let email: String
    let gold: Double
    let energy: Double
    let totalLevel: Int

    enum CodingKeys: String, CodingKey {
        case username = "Username"
        case email = "Email"
        case gold = "Gold"
        case energy = "Energy"
        case totalLevel = "TotalLevel"
    }
}
