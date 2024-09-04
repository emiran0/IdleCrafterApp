//
//  TrialAppApp.swift
//  TrialApp
//
//  Created by Emiran Kartal on 21.08.2024.
//

import SwiftUI

@main
struct TrialAppApp: App {
    @StateObject var gameManager = GameManager.shared
    
//    init() {
//            MiningManager.shared.startMining()
//    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameManager)
//                .environmentObject(MiningManager.shared)
        }
    }
}

