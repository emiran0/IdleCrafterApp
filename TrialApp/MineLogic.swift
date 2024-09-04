//
//  MineLogic.swift
//  TrialApp
//
//  Created by Emiran Kartal on 3.09.2024.
//

//import Combine
//import SwiftUI
//
//class MiningManager: ObservableObject {
//    static let shared = MiningManager()
//    private var miningTimer: AnyCancellable?
//    @Published var minedMaterials: [String: Int] = [:]
//
//    private init() {
//        loadMinedMaterials()
//    }
//
//    func startMining() {
//        if miningTimer == nil {
//            miningTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
//                .sink { [weak self] _ in
//                    self?.mine()
//                }
//        }
//    }
//
//    func stopMining() {
//        miningTimer?.cancel()
//        miningTimer = nil
//        saveMinedMaterials()  // Save when stopping the mining
//    }
//
//    private func mine() {
//        print("Mining operation triggered")
//        if Int.random(in: 1...3) == 2 { updateMinedMaterials(material: "Stone", increment: 1) }
//        if Int.random(in: 1...10) == 5 { updateMinedMaterials(material: "Copper", increment: 1) }
//        if Int.random(in: 1...25) == 12 { updateMinedMaterials(material: "Iron", increment: 1) }
//    }
//
//    private func updateMinedMaterials(material: String, increment: Int) {
//        DispatchQueue.main.async {
//            self.minedMaterials[material, default: 0] += increment
//        }
//    }
//
//    func saveMinedMaterials() {
//        UserDefaultsManager.shared.saveMinedMaterials(minedMaterials)
//    }
//    
//    private func loadMinedMaterials() {
//        if let loadedMaterials = UserDefaultsManager.shared.loadMinedMaterials() {
//            minedMaterials = loadedMaterials
//        }
//    }
//}
