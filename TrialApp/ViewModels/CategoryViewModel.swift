//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//

// ViewModels/CategoryViewModel.swift

import Foundation
import Combine

class CategoryViewModel: ObservableObject {
    @Published var tools: [ToolData] = []
    @Published var items: [ItemData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        guard NetworkManager.shared.token != nil else {
            // User is not logged in; do not fetch data
            return
        }
        
        isLoading = true
        
        let toolsPublisher = NetworkManager.shared.fetchUserTools()
        let itemsPublisher = NetworkManager.shared.fetchUserItems()
        
        Publishers.Zip(toolsPublisher, itemsPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { toolsResponse, itemsResponse in
                self.tools = toolsResponse.toolsByCategory.values.flatMap { $0 }
                self.items = itemsResponse.itemsByCategory.values.flatMap { $0 }
                //                print("Fetched Tools: \(self.tools)")
                //                print("Fetched Items: \(self.items)")
            })
            .store(in: &cancellables)
    }
}
