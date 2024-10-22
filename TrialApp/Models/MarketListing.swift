// Models/MarketListing.swift

import Foundation

struct MarketListing: Codable, Identifiable {
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