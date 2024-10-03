//
//  ItemsInfoView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 3.10.2024.
//

import SwiftUI

struct ItemsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Items Information")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                // Mining Items Section
                CollapsibleItemsCategoryView(categoryName: "Mining Items", items: [
                    ItemDetail(name: "Stone", description: "Non-smeltable ore.", rarity: "1/2"),
                    ItemDetail(name: "Emerald", description: "Non-smeltable ore.", rarity: "1/2000"),
                    ItemDetail(name: "Diamond", description: "Non-smeltable ore.", rarity: "1/10000"),
                    ItemDetail(name: "Quartz", description: "Non-smeltable ore.", rarity: "1/30000"),
                    ItemDetail(name: "Copper", description: "Smeltable ore.", rarity: "1/5", resources: ["Req. Oil: -", "Req. Charcoal: -", "XP: 10"]),
                    ItemDetail(name: "Iron", description: "Smeltable ore.", rarity: "1/10", resources: ["Req. Oil: -", "Req. Charcoal: -", "XP: 25"]),
                    ItemDetail(name: "Silver", description: "Smeltable ore.", rarity: "1/25", resources: ["Req. Oil: 2", "Req. Charcoal: -", "XP: 75"]),
                    ItemDetail(name: "Gold", description: "Smeltable ore.", rarity: "1/50", resources: ["Req. Oil: 10", "Req. Charcoal: 5", "XP: 300"]),
                    ItemDetail(name: "Titanium", description: "Smeltable ore.", rarity: "1/500", resources: ["Req. Oil: 200", "Req. Charcoal: 20", "XP: 2000"]),
                    ItemDetail(name: "Flintstone", description: "Creates sparks to get fire.", rarity: "Acquired at level 3"),
                    ItemDetail(name: "Oil", description: "The source of power for mining tools.", rarity: "-")
                ])

                // Farming Items Section
                CollapsibleItemsCategoryView(categoryName: "Farming Items", items: [
                    ItemDetail(name: "Moonberry Seed", description: "Plantable seed.", rarity: "1/200", resources: ["Growing Time: 300 sec", "After Harvested: Lunar Berries", "XP: 10"]),
                    ItemDetail(name: "Sungrain Seed", description: "Plantable seed.", rarity: "1/600", resources: ["Growing Time: 600 sec", "After Harvested: Golden Sheaf", "XP: 35"]),
                    ItemDetail(name: "Fireleaf Seed", description: "Plantable seed.", rarity: "1/2000", resources: ["Growing Time: 1500 sec", "After Harvested: Blazebloom", "XP: 100"]),
                    ItemDetail(name: "Aquasprout Seed", description: "Plantable seed.", rarity: "1/5000", resources: ["Growing Time: 3600 sec", "After Harvested: Tidefruits", "XP: 400"]),
                    ItemDetail(name: "Nightshade Seed", description: "Plantable seed.", rarity: "1/20000", resources: ["Growing Time: 7200 sec", "After Harvested: Midnight Petals", "XP: 1000"]),
                    ItemDetail(name: "Glowroot Seed", description: "Plantable seed.", rarity: "1/50000", resources: ["Growing Time: 43200 sec", "After Harvested: Radiant Tubers", "XP: 18000"])
                ])

                // Woodcutting Items Section
                CollapsibleItemsCategoryView(categoryName: "Woodcutting Items", items: [
                    ItemDetail(name: "Oak Logs", description: "Logs from Oak trees.", rarity: "1/600", resources: ["Min Log: 50", "Max Log: 80", "XP: 5"]),
                    ItemDetail(name: "Pine Logs", description: "Logs from Pine trees.", rarity: "1/2000", resources: ["Min Log: 55", "Max Log: 85", "XP: 30"]),
                    ItemDetail(name: "Maple Logs", description: "Logs from Maple trees.", rarity: "1/5000", resources: ["Min Log: 60", "Max Log: 90", "XP: 80"]),
                    ItemDetail(name: "Birch Logs", description: "Logs from Birch trees.", rarity: "1/10000", resources: ["Min Log: 60", "Max Log: 90", "XP: 400"]),
                    ItemDetail(name: "Cedar Logs", description: "Logs from Cedar trees.", rarity: "1/50000", resources: ["Min Log: 100", "Max Log: 130", "XP: 1000"])
                ])

                // Fishing Items Section
                CollapsibleItemsCategoryView(categoryName: "Fishing Items", items: [
                    ItemDetail(name: "Trout", description: "Cookable fish.", rarity: "1/100", resources: ["Fire To Cook: 10", "XP: 10"]),
                    ItemDetail(name: "Salmon", description: "Cookable fish.", rarity: "1/500", resources: ["Fire To Cook: 25", "XP: 25"]),
                    ItemDetail(name: "Tuna", description: "Cookable fish.", rarity: "1/2000", resources: ["Fire To Cook: 100", "XP: 50"]),
                    ItemDetail(name: "Swordfish", description: "Cookable fish.", rarity: "1/10000", resources: ["Fire To Cook: 500", "XP: 300"]),
                    ItemDetail(name: "Golden Koi", description: "Cookable fish.", rarity: "1/50000", resources: ["Fire To Cook: 2000", "XP: 1000"])
                ])

                // Alchemy Items Section
                CollapsibleItemsCategoryView(categoryName: "Alchemy Items", items: [
                    ItemDetail(name: "Potion of Enhanced Yield", description: "Increases crop yield by 20%.", resources: ["Needed: 2 Golden Sheaf, 1 Tidefruit, 1 Lunar Berries", "Timer: 1800 sec", "XP: 25"]),
                    ItemDetail(name: "Miner’s Brew", description: "Boosts mining speed by 15%.", resources: ["Needed: 3 Blazebloom, 2 Radiant Tubers", "Timer: 3600 sec", "XP: 60"]),
                    ItemDetail(name: "Potion of Lumberjack’s Strength", description: "Increases log yield by 25%.", resources: ["Needed: 2 Blazebloom, 2 Golden Sheaf", "Timer: 2700 sec", "XP: 140"]),
                    ItemDetail(name: "Fisherman’s Elixir", description: "Enhances chance of catching rare fish by 30%.", resources: ["Needed: 2 Tidefruits, 1 Lunar Berries, 1 Midnight Petals", "Timer: 7200 sec", "XP: 400"]),
                    ItemDetail(name: "Trader’s Tonic", description: "Increases selling price by 15%.", resources: ["Needed: 2 Golden Sheaf, 1 Lunar Berries, 1 Radiant Tuber", "Timer: 120 sec", "XP: 1500"]),
                    ItemDetail(name: "Smelter’s Draught", description: "Increases furnace speed by 20%.", resources: ["Needed: 2 Blazebloom, 1 Tidefruit, 1 Radiant Tuber", "Timer: 1800 sec", "XP: 4000"])
                ])

            }
            .padding()
        }
        .navigationTitle("Items")
    }
}

struct ItemDetail {
    var name: String
    var description: String
    var rarity: String?
    var resources: [String] = []
}

struct CollapsibleItemsCategoryView: View {
    var categoryName: String
    var items: [ItemDetail]
    @State private var isExpanded = false

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            VStack(alignment: .leading) {
                ForEach(items, id: \.name) { item in
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.title3)
                            .fontWeight(.bold)
                        Text(item.description)
                        if let rarity = item.rarity {
                            Text("Rarity: \(rarity)")
                                .italic()
                        }
                        if !item.resources.isEmpty {
                            Text("Resources: \(item.resources.joined(separator: ", "))")
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
