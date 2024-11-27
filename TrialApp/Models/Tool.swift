//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Models/Tool.swift

import Foundation

struct ToolData: Codable, Identifiable {
    let id = UUID()
    let uniqueToolName: String
    let displayName: String
    let toolID: Int?
    let isRepeating: Bool?
    var isEnabled: Bool?
    let isOccupied: Bool?
    let tier: Int?
    let lastUsed: String?
    let ongoingCraftingItemUniqueName: String?
    let ongoingRemainedQuantity: Int?

    // Add the computed property
    var iconName: String {
        return "icon_\(uniqueToolName)"
    }

    enum CodingKeys: String, CodingKey {
        case uniqueToolName = "unique_tool_name"
        case displayName = "display_name"
        case toolID = "ToolId"
        case isRepeating = "isRepeating"
        case isEnabled = "isEnabled"
        case isOccupied = "isOccupied"
        case tier = "Tier"
        case lastUsed = "LastUsed"
        case ongoingCraftingItemUniqueName = "ongoingCraftingItemUniqueName"
        case ongoingRemainedQuantity = "OngoingRemainedQuantity"
    }
}

struct UserToolsResponse: Codable {
    let toolsByCategory: [String: [ToolData]]

    enum CodingKeys: String, CodingKey {
        case toolsByCategory = "tools_by_category"
    }
}

struct ToolToggleResponse: Codable {
    let toolUniqueName: String
    let isEnabled: Bool

    enum CodingKeys: String, CodingKey {
        case toolUniqueName = "tool_unique_name"
        case isEnabled = "isEnabled"
    }
}
