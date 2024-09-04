//
//  ItemData.swift
//  TrialApp
//
//  Created by Emiran Kartal on 4.09.2024.
//

import Foundation

struct CategoryID {
    static let mining = 11
    static let crafting = 12
    static let farming = 13
    static let woodcutting = 14
    static let alchemy = 15
    static let fishing = 16
    static let cooking = 17
    static let combat = 18
}

// MINING ITEMS
let stone = Item(categoryID: CategoryID.mining, itemName: "stone", itemIconName: "iconItemStone", probability: 2, collectOrder: 0)
let copper = Item(categoryID: CategoryID.mining, itemName: "copper", itemIconName: "iconItemCopper", probability: 4, collectOrder: 0)
let iron = Item(categoryID: CategoryID.mining, itemName: "iron", itemIconName: "iconItemIron", probability: 10, collectOrder: 0)
let silver = Item(categoryID: CategoryID.mining, itemName: "silver", itemIconName: "iconItemSilver", probability: 50, collectOrder: 1)
let emerald = Item(categoryID: CategoryID.mining, itemName: "emerald", itemIconName: "iconItemEmerald", probability: 1000, collectOrder: 1)
//

// CRAFTING ITEMS

//

// FARMING ITEMS

//

// WOODCUTTING ITEMS

//
