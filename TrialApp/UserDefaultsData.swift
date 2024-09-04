//
//  UserDefaultsData.swift
//  TrialApp
//
//  Created by Emiran Kartal on 3.09.2024.
//

//import Foundation
//
//class UserDefaultsManagers {
//    static let shared = UserDefaultsManager()
//    
//    private init() {}  // Private initializer to ensure singleton usage
//
//    // Key definitions
//    private let minedMaterialsKey = "minedMaterials"
//    
//    // Save mined materials to UserDefaults
//    func saveMinedMaterials(_ minedMaterials: [String: Int]) {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(minedMaterials) {
//            UserDefaults.standard.set(encoded, forKey: minedMaterialsKey)
//        }
//    }
//    
//    // Load mined materials from UserDefaults
//    func loadMinedMaterials() -> [String: Int]? {
//        if let savedData = UserDefaults.standard.data(forKey: minedMaterialsKey) {
//            let decoder = JSONDecoder()
//            if let loadedMaterials = try? decoder.decode([String: Int].self, from: savedData) {
//                return loadedMaterials
//            }
//        }
//        return nil  // Return nil if there's no data or decoding fails
//    }
//}

