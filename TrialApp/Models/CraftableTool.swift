//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Models/CraftableTool.swift

import Foundation

struct CraftableTool: Codable, Identifiable {
    let id = UUID()
    let uniqueToolName: String
    let displayName: String
    let tier : Int
    let requiredItems: [RequiredItem]
    let category: String
    let minimumLevel: Int

    enum CodingKeys: String, CodingKey {
        case uniqueToolName = "unique_tool_name"
        case displayName = "display_name"
        case tier = "tier"
        case requiredItems = "required_items"
        case category = "category"
        case minimumLevel = "minimum_category_level"
    }
}
