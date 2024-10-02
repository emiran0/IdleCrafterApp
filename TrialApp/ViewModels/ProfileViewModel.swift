//  TrialApp
//
//  Created by Emiran Kartal on 2.10.2024.
//
// ViewModels/ProfileViewModel.swift

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchUserProfile() {
        isLoading = true

        NetworkManager.shared.fetchUserProfile()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching user profile: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { profile in
                self.userProfile = profile
                print("Fetched User Profile: \(profile)")
            })
            .store(in: &cancellables)
    }
}
