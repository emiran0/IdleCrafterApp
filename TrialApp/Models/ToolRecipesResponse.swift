//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Models/ToolRecipesResponse.swift

import Foundation

struct ToolRecipesResponse: Codable, Identifiable {
    let id = UUID()
    let uniqueToolName: String
    let toolTier: Int
    let recipeList: [CraftableItem]

    enum CodingKeys: String, CodingKey {
        case uniqueToolName = "unique_tool_name"
        case toolTier = "tool_tier"
        case recipeList = "recipe_list"
    }
}
