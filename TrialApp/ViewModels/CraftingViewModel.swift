//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// ViewModels/CraftingViewModel.swift

import Foundation
import Combine

class CraftingViewModel: ObservableObject {
    @Published var craftableTools: [CraftableTool] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchCraftableTools() {
        isLoading = true
        
        NetworkManager.shared.fetchCraftableTools()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching craftable tools: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { craftableTools in
                self.craftableTools = craftableTools
                print("Fetched Craftable Tools: \(self.craftableTools)")
            })
            .store(in: &cancellables)
    }
    
    func craftTool(toolUniqueName: String, toolTier: Int) {
        NetworkManager.shared.craftTool(toolUniqueName: toolUniqueName, toolTier: toolTier)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.alertMessage = "\(self.errorMessage ?? "")"
                    self.showAlert = true
                    print("Error crafting tool: \(error)")
                case .finished:
                    print("Successfully crafted tool: \(toolUniqueName)")
                    // Optionally refresh data or update UI
                    self.alertMessage = "Tool crafted successfully!"
                    self.showAlert = true
                    
                    self.fetchCraftableTools()
                }
            }, receiveValue: { })
            .store(in: &cancellables)
    }
}
