//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Models/InputItem.swift

import Foundation

struct InputItem: Codable, Identifiable {
    let id = UUID()
    let inputItemUniqueName: String
    let inputItemDisplayName: String
    let inputItemQuantity: Int

    enum CodingKeys: String, CodingKey {
        case inputItemUniqueName = "input_item_unique_name"
        case inputItemDisplayName = "input_item_display_name"
        case inputItemQuantity = "input_item_quantity"
    }
}
