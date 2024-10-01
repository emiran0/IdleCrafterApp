//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Models/CraftableItem.swift

import Foundation

struct CraftableItem: Codable, Identifiable {
    let id = UUID()
    let outputItemUniqueName: String
    let outputItemDisplayName: String
    let generationDuration: Int
    let inputItems: [InputItem]

    enum CodingKeys: String, CodingKey {
        case outputItemUniqueName = "output_item_unique_name"
        case outputItemDisplayName = "output_item_display_name"
        case generationDuration = "generation_duration"
        case inputItems = "input_items"
    }
}
