//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Models/RequiredItem.swift

import Foundation

struct RequiredItem: Codable, Identifiable {
    let id = UUID()
    let itemUniqueName: String
    let itemDisplayName: String
    let requiredQuantity: Int

    enum CodingKeys: String, CodingKey {
        case itemUniqueName = "item_unique_name"
        case itemDisplayName = "item_display_name"
        case requiredQuantity = "required_quantity"
    }
}

