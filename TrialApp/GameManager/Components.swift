//
//  Items.swift
//  TrialApp
//
//  Created by Emiran Kartal on 4.09.2024.
//

import Foundation

class Item: Identifiable, ObservableObject, Codable {
    let id = UUID()
    var categoryID: Int
    @Published var itemName: String
    @Published var itemCount: Int
    @Published var itemIconName: String
    @Published var probability: Int?
    @Published var collectOrder: Int?
    @Published var acquired: Bool = false  // Track if the item is acquired

    enum CodingKeys: String, CodingKey {
        case id, categoryID, itemName, itemCount, itemIconName, probability, collectOrder, acquired
    }

    init(categoryID: Int, itemName: String, itemIconName: String, itemCount: Int = 0, probability: Int? = nil, collectOrder: Int? = nil) {
        self.categoryID = categoryID
        self.itemName = itemName
        self.itemIconName = itemIconName
        self.itemCount = itemCount
        self.probability = probability
        self.collectOrder = collectOrder
        self.acquired = itemCount > 0
    }

    // Decoding method
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _ = try container.decode(UUID.self, forKey: .id)  // You can't decode id because it is always auto-generated
        categoryID = try container.decode(Int.self, forKey: .categoryID)
        itemName = try container.decode(String.self, forKey: .itemName)
        itemCount = try container.decode(Int.self, forKey: .itemCount)
        itemIconName = try container.decode(String.self, forKey: .itemIconName)
        probability = try container.decodeIfPresent(Int.self, forKey: .probability)
        collectOrder = try container.decodeIfPresent(Int.self, forKey: .collectOrder)
        acquired = try container.decode(Bool.self, forKey: .acquired)
    }

    // Encoding method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(categoryID, forKey: .categoryID)
        try container.encode(itemName, forKey: .itemName)
        try container.encode(itemCount, forKey: .itemCount)
        try container.encode(itemIconName, forKey: .itemIconName)
        try container.encodeIfPresent(probability, forKey: .probability)
        try container.encodeIfPresent(collectOrder, forKey: .collectOrder)
        try container.encode(acquired, forKey: .acquired)
    }
}

class Tool: Identifiable, ObservableObject, Codable {
    let id = UUID()
    @Published var toolName: String
    @Published var crafted: Bool = false  // Track if the tool has been crafted
    @Published var managedItems: [Item]
    @Published var permissionOrder: Int?
    

    enum CodingKeys: String, CodingKey {
        case id, toolName, crafted, managedItems, permissionOrder
    }

    init(toolName: String, managedItems: [Item], permissionOrder: Int? = nil) {
        self.toolName = toolName
        self.managedItems = managedItems
        self.permissionOrder = permissionOrder
    }

    // Decoding method
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _ = try container.decode(UUID.self, forKey: .id)  // Decode but ignore the UUID
        toolName = try container.decode(String.self, forKey: .toolName)
        crafted = try container.decode(Bool.self, forKey: .crafted)
        managedItems = try container.decode([Item].self, forKey: .managedItems)
        permissionOrder = try container.decodeIfPresent(Int.self, forKey: .permissionOrder)
    }

    // Encoding method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(toolName, forKey: .toolName)
        try container.encode(crafted, forKey: .crafted)
        try container.encode(managedItems, forKey: .managedItems)
        try container.encodeIfPresent(permissionOrder, forKey: .permissionOrder)
    }
    
    func collectResources() {
        // Collect items with probabilities
        DispatchQueue.main.async {
            self.managedItems.forEach { item in
                if let probability = item.probability, Int.random(in: 1...probability) == probability/2 {
                    print("item gathered and increased with 1")
                    item.itemCount += 1
                    item.acquired = true
                    print("Collected \(item.itemName), new count: \(item.itemCount)")
                }
            }
        }
    }

    func craft() {
        crafted = true
    }
}


class PlayerStats: ObservableObject, Codable {
    @Published var gold: Int = 0
    @Published var energy: Int = 100
    @Published var totalLevel: Int = 1

    enum CodingKeys: String, CodingKey {
        case gold, energy, totalLevel
    }

    init(gold: Int = 0, energy: Int = 100, totalLevel: Int = 1) {
        self.gold = gold
        self.energy = energy
        self.totalLevel = totalLevel
    }

    // Decoding method
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gold = try container.decode(Int.self, forKey: .gold)
        energy = try container.decode(Int.self, forKey: .energy)
        totalLevel = try container.decode(Int.self, forKey: .totalLevel)
    }

    // Encoding method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(gold, forKey: .gold)
        try container.encode(energy, forKey: .energy)
        try container.encode(totalLevel, forKey: .totalLevel)
    }
}


//import Foundation
//import SwiftUI
//
//class Item: Identifiable, ObservableObject, Codable {
//    let id: UUID
//    var categoryID: Int  // Now an Int representing different categories
//    @Published var itemName: String
//    @Published var itemIconName: String
//    @Published var goldWorth: Int?
//    @Published var itemCount: Int
//    @Published var probability: Int?
//    @Published var isWorking: Bool = false
//
//        enum CodingKeys: String, CodingKey {
//            case id, categoryID, itemName, itemIconName, goldWorth, itemCount, probability, isWorking
//        }
//    
//    init(id: UUID = UUID(), categoryID: Int, itemName: String, itemIconName: String, goldWorth: Int? = nil, itemCount: Int = 0, probability: Int? = nil, isWorking: Bool = false) {
//            self.id = id
//            self.categoryID = categoryID
//            self.itemName = itemName
//            self.itemIconName = itemIconName
//            self.goldWorth = goldWorth
//            self.itemCount = itemCount
//            self.probability = probability
//            self.isWorking = isWorking
//    }
//
//        required init(from decoder: Decoder) throws {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            id = try container.decode(UUID.self, forKey: .id)
//            categoryID = try container.decode(Int.self, forKey: .categoryID)
//            itemName = try container.decode(String.self, forKey: .itemName)
//            itemIconName = try container.decode(String.self, forKey: .itemIconName)
//            goldWorth = try container.decodeIfPresent(Int.self, forKey: .goldWorth)
//            itemCount = try container.decode(Int.self, forKey: .itemCount)
//            probability = try container.decodeIfPresent(Int.self, forKey: .probability)
//            isWorking = try container.decode(Bool.self, forKey: .isWorking)
//        }
//
//        func encode(to encoder: Encoder) throws {
//            var container = encoder.container(keyedBy: CodingKeys.self)
//            try container.encode(id, forKey: .id)
//            try container.encode(categoryID, forKey: .categoryID)
//            try container.encode(itemName, forKey: .itemName)
//            try container.encode(itemIconName, forKey: .itemIconName)
//            try container.encodeIfPresent(goldWorth, forKey: .goldWorth)
//            try container.encode(itemCount, forKey: .itemCount)
//            try container.encodeIfPresent(probability, forKey: .probability)
//            try container.encode(isWorking, forKey: .isWorking)
//        }
//}




