//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// ViewModels/MiningViewModel.swift

import Foundation
import Combine

class MiningViewModel: ObservableObject {
    @Published var tool: ToolData
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    init(tool: ToolData) {
        self.tool = tool
    }

    func toggleToolEnabled() {
        NetworkManager.shared.toggleToolEnabled(toolUniqueName: tool.uniqueToolName)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.tool.isEnabled = response.isEnabled
            })
            .store(in: &cancellables)
    }
}
