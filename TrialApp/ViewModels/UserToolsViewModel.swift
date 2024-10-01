//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// ViewModels/UserToolsViewModel.swift

import Foundation
import Combine

class UserToolsViewModel: ObservableObject {
    @Published var toolsByCategory: [String: [ToolData]] = [:]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable?

    init() {
        fetchUserTools()
        startTimer()
    }

    func fetchUserTools() {
        isLoading = true
        NetworkManager.shared.fetchUserTools()
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { response in
                self.toolsByCategory = response.toolsByCategory
            })
            .store(in: &cancellables)
    }

    func startTimer() {
        timer = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.fetchUserTools()
            }
    }

    func stopTimer() {
        timer?.cancel()
    }

    deinit {
        stopTimer()
    }
}
