//
//  ToolsInfoView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 3.10.2024.
//

import SwiftUI


struct ToolsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Tools Information")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                // Mining Tools Section
                CollapsibleToolsCategoryView(categoryName: "Mining Tools", tools: [
                    ToolDetail(name: "Furnace", description: "Smelts ores.", tierInfo: "Stone Furnace, Iron Furnace, Diamond Furnace", resources: ["Oil", "Charcoal"]),
                    ToolDetail(name: "Pickaxe", description: "Mines stones and ores without oil consumption.", tierInfo: "Wooden Pickaxe, Iron Pickaxe, Diamond Pickaxe", resources: []),
                    ToolDetail(name: "Oil Extractor", description: "Yields liters of oil every second.", tierInfo: "Basic Oil Extractor, Diamond Oil Extractor, Ocean Oil Platform", resources: []),
                    ToolDetail(name: "Drill", description: "Mines ores with oil consumption.", tierInfo: nil, resources: ["Uses 1 L/s of oil"]),
                    ToolDetail(name: "Excavator", description: "Mines ores with a higher oil consumption.", tierInfo: nil, resources: ["Uses 5 L/s of oil"]),
                    ToolDetail(name: "Tunnel Borer", description: "Mines ores with high oil consumption.", tierInfo: nil, resources: ["Uses 10 L/s of oil"]),
                    ToolDetail(name: "Plasma Cutter", description: "Mines ores with extremely high oil consumption.", tierInfo: nil, resources: ["Uses 24 L/s of oil"])
                ])

                // Farming Tools Section
                CollapsibleToolsCategoryView(categoryName: "Farming Tools", tools: [
                    ToolDetail(name: "Rake", description: "Automatically collects seeds.", tierInfo: "Stone Rake, Iron Rake, Diamond Rake", resources: [])
                ])

                // Woodcutting Tools Section
                CollapsibleToolsCategoryView(categoryName: "Woodcutting Tools", tools: [
                    ToolDetail(name: "Axe", description: "Collects logs from grown trees.", tierInfo: nil, resources: ["Collects default amount of logs"]),
                    ToolDetail(name: "Manual Saw", description: "Boosts log collection by +50%.", tierInfo: nil, resources: []),
                    ToolDetail(name: "Saw Machine", description: "Boosts log collection by +100%.", tierInfo: nil, resources: [])
                ])

                // Fishing Tools Section
                CollapsibleToolsCategoryView(categoryName: "Fishing Tools", tools: [
                    ToolDetail(name: "Fishing Rod", description: "Enables fishing and catching rare items.", tierInfo: nil, resources: []),
                    ToolDetail(name: "Fishing Net", description: "Increases fishing abilities.", tierInfo: nil, resources: []),
                    ToolDetail(name: "Harpoon", description: "Enables catching legendary fish.", tierInfo: nil, resources: [])
                ])

                // Alchemy Tools Section
                CollapsibleToolsCategoryView(categoryName: "Alchemy Tools", tools: [
                    ToolDetail(name: "Mortar and Pestle", description: "Enables alchemy for basic spells and potions.", tierInfo: nil, resources: []),
                    ToolDetail(name: "Cauldron", description: "Creates strong spells and potions.", tierInfo: nil, resources: [])
                ])

                // Crafting Tools Section
                CollapsibleToolsCategoryView(categoryName: "Crafting Tools", tools: [
                    ToolDetail(name: "Hammer", description: "Enables basic item/tool creation.", tierInfo: "Wooden Hammer, Iron Hammer, Diamond Hammer", resources: []),
                    ToolDetail(name: "Crafting Table", description: "Unlocks new item/tool schemas.", tierInfo: nil, resources: [])
                ])

                // Cooking Tools Section
                CollapsibleToolsCategoryView(categoryName: "Cooking Tools", tools: [
                    ToolDetail(name: "Campfire", description: "Enables basic cooking.", tierInfo: nil, resources: []),
                    ToolDetail(name: "Oven", description: "Cooks more items and reduces cooking time by 40%.", tierInfo: nil, resources: [])
                ])
            }
            .padding()
        }
        .navigationTitle("Tools")
    }
}

struct ToolDetail {
    var name: String
    var description: String
    var tierInfo: String?
    var resources: [String]
}

struct CollapsibleToolsCategoryView: View {
    var categoryName: String
    var tools: [ToolDetail]
    @State private var isExpanded = false

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading) {
                ForEach(tools, id: \.name) { tool in
                    VStack(alignment: .leading) {
                        Text(tool.name)
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(tool.description)
                        if let tierInfo = tool.tierInfo {
                            Text("Tiers: \(tierInfo)")
                                .italic()
                        }
                        if !tool.resources.isEmpty {
                            Text("Resources: \(tool.resources.joined(separator: ", "))")
                        }
                    }
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.2))
                            .padding(.vertical, 5)
                    )
                }
            }
        } label: {
            Text(categoryName)
                .font(.headline)
                .padding(.vertical, 5)
        }
        .padding(.vertical, 5)
    }
}
