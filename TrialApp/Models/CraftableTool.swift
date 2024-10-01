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
    let requiredItems: [RequiredItem]

    enum CodingKeys: String, CodingKey {
        case uniqueToolName = "unique_tool_name"
        case displayName = "display_name"
        case requiredItems = "required_items"
    }
}
