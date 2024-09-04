//
//  UserDefaultsManager.swift
//  TrialApp
//
//  Created by Emiran Kartal on 4.09.2024.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private init() {}

    // Save and Load items
    func saveItems(_ items: [UUID: Item]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "items")
            UserDefaults.standard.synchronize()
        }
    }

    func loadItems() -> [UUID: Item] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "items"),
           let items = try? decoder.decode([UUID: Item].self, from: data) {
            return items
        }
        return [:]
    }

    // Save and Load Tool States (if applicable)
    // Example function - Adjust according to actual tool management requirements
    func saveToolStatuses(_ statuses: [String: Int]) {
        UserDefaults.standard.set(statuses, forKey: "toolStatuses")
        UserDefaults.standard.synchronize()
    }

    func loadToolStatuses() -> [String: Int] {
        return UserDefaults.standard.dictionary(forKey: "toolStatuses") as? [String: Int] ?? [:]
    }

    // Handling other game-related data
    func saveGameStats(_ stats: [String: Any]) {
        for (key, value) in stats {
            UserDefaults.standard.set(value, forKey: key)
        }
        UserDefaults.standard.synchronize()
    }

    func loadGameStats() -> [String: Any] {
        // Implement based on specific stats keys
        return [:]
    }
}

