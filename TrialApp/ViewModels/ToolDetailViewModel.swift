//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// ViewModels/ToolDetailViewModel.swift

import Foundation
import Combine

class ToolDetailViewModel: ObservableObject {
    @Published var toolRecipes: ToolRecipesResponse?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showCraftSuccess: Bool = false
    @Published var desiredQuantities: [UUID: String] = [:]
    
    private var cancellables = Set<AnyCancellable>()

    func fetchItemCraftingRecipes(for toolUniqueName: String) {
        isLoading = true

        NetworkManager.shared.fetchItemCraftingRecipes(for: toolUniqueName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching item crafting recipes: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { toolRecipes in
                self.toolRecipes = toolRecipes
                print("Fetched Tool Recipes: \(String(describing: self.toolRecipes))")
            })
            .store(in: &cancellables)
    }

    func craftItem(toolUniqueName: String, itemUniqueName: String, quantity: Int) {
        NetworkManager.shared.craftItem(itemUniqueName: itemUniqueName, quantity: quantity)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error crafting item: \(error)")
                case .finished:
                    print("Successfully crafted item: \(itemUniqueName)")
                    self.fetchItemCraftingRecipes(for: toolUniqueName)
                    self.showCraftSuccess = true
                }
            }, receiveValue: { })
            .store(in: &cancellables)
    }
}
