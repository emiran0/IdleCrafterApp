//
//  ProfileImageManager.swift
//  TrialApp
//
//  Created by Emiran Kartal on 31.10.2024.
//


import Foundation
import SwiftUI

class ProfileImageManager {
    static let shared = ProfileImageManager()
    private init() {}

    private let imageFileName = "profile_image.png"

    func saveImage(_ image: UIImage) {
        guard let data = image.pngData() else { return }
        let url = getDocumentsDirectory().appendingPathComponent(imageFileName)
        do {
            try data.write(to: url)
        } catch {
            print("Error saving image: \(error)")
        }
    }

    func loadImage() -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(imageFileName)
        if FileManager.default.fileExists(atPath: url.path) {
            return UIImage(contentsOfFile: url.path)
        }
        return nil
    }

    func deleteImage() {
        let url = getDocumentsDirectory().appendingPathComponent(imageFileName)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print("Error deleting image: \(error)")
            }
        }
    }

    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
