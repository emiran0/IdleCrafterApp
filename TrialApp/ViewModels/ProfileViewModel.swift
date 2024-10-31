//  TrialApp
//
//  Created by Emiran Kartal on 2.10.2024.
//
// ViewModels/ProfileViewModel.swift

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var userProfile: UserProfile?

    private var cancellables = Set<AnyCancellable>()

    func fetchUserProfile() {
        isLoading = true
        errorMessage = nil

        NetworkManager.shared.fetchUserProfile()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching profile: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] profile in
                self?.userProfile = profile
            })
            .store(in: &cancellables)
    }
}
