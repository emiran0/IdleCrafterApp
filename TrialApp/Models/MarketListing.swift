//
//  MarketListing.swift
//  TrialApp
//
//  Created by Emiran Kartal on 22.10.2024.
//


// Models/MarketListing.swift

import Foundation

struct MarketListing: Codable, Identifiable, Hashable {
    let id: Int
    let sellerId: String
    let sellerUsername: String
    let itemUniqueName: String
    let itemDisplayName: String
    let itemDescription: String?
    let quantity: Int
    let price: Double
    let listCreatedAt: Date
    let expireDate: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case sellerId = "seller_id"
        case sellerUsername = "seller_username"
        case itemUniqueName = "item_unique_name"
        case itemDisplayName = "item_display_name"
        case itemDescription = "item_description"
        case quantity
        case price
        case listCreatedAt = "list_created_at"
        case expireDate = "expire_date"
    }
}

struct MarketListingsResponse: Codable {
    let listings: [MarketListing]
}


struct ListItemRequest: Codable {
    let itemUniqueName: String
    let quantity: Int
    let price: Double
    let expireDate: Date?

    enum CodingKeys: String, CodingKey {
        case itemUniqueName = "item_unique_name"
        case quantity
        case price
        case expireDate = "expire_date"
    }
}

struct ListItemResponse: Codable {
    let status: String
    let message: String
    let listingId: Int

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case listingId = "listing_id"
    }
}


struct BuyItemRequest: Codable {
    let listingId: Int
    let quantity: Int

    enum CodingKeys: String, CodingKey {
        case listingId = "listing_id"
        case quantity
    }
}

struct BuyItemResponse: Codable {
    let status: String
    let message: String
    let totalPrice: Double
    let itemUniqueName: String
    let itemDisplayName: String
    let quantityBought: Int
    let buyerGoldBalance: Double

    enum CodingKeys: String, CodingKey {
        case status
        case message
        case totalPrice = "total_price"
        case itemUniqueName = "item_unique_name"
        case itemDisplayName = "item_display_name"
        case quantityBought = "quantity_bought"
        case buyerGoldBalance = "buyer_gold_balance"
    }
}


struct CancelListingRequest: Codable {
    let listingId: Int

    enum CodingKeys: String, CodingKey {
        case listingId = "listing_id"
    }
}

struct CancelListingResponse: Codable {
    let status: String
    let message: String
}
