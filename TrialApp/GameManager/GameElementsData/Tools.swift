////
////  Tools.swift
////  TrialApp
////
////  Created by Emiran Kartal on 4.09.2024.
////
//
//import Foundation
//
//// Define a basic protocol for tools to ensure common functionalities.
//protocol Tool {
//    var status: Int { get set }  // 0 for IDLE, 1 for WORKING
//    func use()
//    func toggleStatus()
//}
//
//// Define the Pickaxe class for mining operations.
//class Pickaxe: Tool {
//    @Published var status: Int = 1
//    var managedItems: [Item]  // Holds direct references to items
//
//    init(managedItems: [Item]) {
//        self.managedItems = managedItems
//    }
//
//
//    // Mining operation which only proceeds if the tool is in WORKING status.
//    private func mine() {
//        if status == 1 {
//            for index in managedItems.indices {
//                let item = managedItems[index]
//                if let probability = item.probability, Int.random(in: 1...probability) == probability/2 {
//                    DispatchQueue.main.async {
//                        item.itemCount += 1
//                    }
//                    print("Mined \(item.itemName), new count: \(item.itemCount)")
//                }
//            }
//        }
//    }
//        
//
//    func use() {
//        mine()
//    }
//
//    // Toggle status between IDLE and WORKING.
//    func toggleStatus() {
//        status = (status == 0) ? 1 : 0
//        print("Pickaxe status toggled to \(status == 1 ? "WORKING" : "IDLE")")
//    }
//}
//
//
//// Category identifiers for ease of managing item types and filtering.
//struct CategoryID {
//    static let mining = 11
//    static let crafting = 12
//    static let farming = 13
//    static let woodcutting = 14
//}
//
