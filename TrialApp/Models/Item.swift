//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Models/Item.swift

import Foundation

struct ItemData: Codable, Identifiable, Hashable {
    let id = UUID()
    let itemUniqueName: String
    let itemQuantity: Int
    let itemDisplayName: String
    let itemGoldValue: Double

    // Add the computed property
    var iconName: String {
        return "icon_\(itemUniqueName)"
    }

    enum CodingKeys: String, CodingKey {
        case itemUniqueName = "item_unique_name"
        case itemQuantity = "item_quantity"
        case itemDisplayName = "item_display_name"
        case itemGoldValue = "item_gold_value"
    }
}

struct UserItemsResponse: Codable {
    let itemsByCategory: [String: [ItemData]]

    enum CodingKeys: String, CodingKey {
        case itemsByCategory = "items_by_category"
    }
}
