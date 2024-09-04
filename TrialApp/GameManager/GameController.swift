//
//  GameController.swift
//  TrialApp
//
//  Created by Emiran Kartal on 4.09.2024.
//

import Foundation
import Combine

class GameManager: ObservableObject {
    static let shared = GameManager()
    @Published var tools: [Tool] = []
    @Published var items: [Item] = []
    @Published var playerStats = PlayerStats()

    private var timer: Timer?

    private init() {
        setupGame()
    }

    // Setup for the game state
    func setupGame() {
        let pickaxe = Tool(toolName: "Pickaxe", managedItems: [stone, iron])
        pickaxe.craft()
        tools.append(pickaxe)
        self.items.append(stone)
        self.items.append(iron)
        self.startCollection()
    }

    // Start the collection timer
    func startCollection() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            self.collectResources()
        }
    }

    func stopCollection() {
        timer?.invalidate()
        timer = nil
    }

    // Collect resources every 5 seconds
    private func collectResources() {
        print("collectResource Triggered")
        tools.forEach { tool in
            if tool.crafted {
                print("triggering tool collectResources")
                tool.collectResources()
            }
        }
//        saveGameState()  // Save progress
    }
    
    func addPredefinedItem(_ item: Item) {
        items.append(item)
    }

    // Add a predefined tool
    func addPredefinedTool(_ tool: Tool) {
        tools.append(tool)
    }

    // Save game state using UserDefaults
    func saveGameState() {
        do {
            let toolsData = try JSONEncoder().encode(tools)
            let itemsData = try JSONEncoder().encode(items)
            let playerStatsData = try JSONEncoder().encode(playerStats)

            UserDefaults.standard.set(toolsData, forKey: "tools")
            UserDefaults.standard.set(itemsData, forKey: "items")
            UserDefaults.standard.set(playerStatsData, forKey: "playerStats")
        } catch {
            print("Failed to save game state: \(error)")
        }
    }

    // Load game state from UserDefaults
    func loadGameState() {
        if let toolsData = UserDefaults.standard.data(forKey: "tools"),
           let itemsData = UserDefaults.standard.data(forKey: "items"),
           let playerStatsData = UserDefaults.standard.data(forKey: "playerStats") {
            do {
                tools = try JSONDecoder().decode([Tool].self, from: toolsData)
                items = try JSONDecoder().decode([Item].self, from: itemsData)
                playerStats = try JSONDecoder().decode(PlayerStats.self, from: playerStatsData)
            } catch {
                print("Failed to load game state: \(error)")
                setupGame()  // Set up a new game if loading fails
            }
        } else {
            setupGame()  // Set up a new game if no saved state exists
        }
    }
}


    // Method to stop all tools by invalidating the timer
//    func stopAllTools() {
//        timer?.invalidate()
//        timer = nil
//    }

    // Optionally, you might want to provide a method to remove tools
//    func removeTool(_ tool: Tool) {
//        if let index = tools.firstIndex(where: { $0 as AnyObject === tool as AnyObject }) {
//            tools.remove(at: index)
//        }
//    }
//}

