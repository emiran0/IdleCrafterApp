//
//  ChatMessage.swift
//  TrialApp
//
//  Created by Emiran Kartal on 28.10.2024.
//
// Models/ChatMessage.swift

import Foundation

struct ChatMessage: Codable, Identifiable {
    let id = UUID()
    let time: Date
    let username: String
    let level: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case time
        case username
        case level
        case text
    }
}
