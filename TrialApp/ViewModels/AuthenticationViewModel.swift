//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// ViewModels/AuthenticationViewModel.swift

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var errorMessage: String?
    @Published var username: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Check if token exists
        isAuthenticated = NetworkManager.shared.token != nil
    }
    
    func login(username: String, password: String) {
        NetworkManager.shared.login(username: username, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.isAuthenticated = true
                    self.username = username
                }
            }, receiveValue: { })
            .store(in: &cancellables)
    }
    
    func signup(username: String, email: String, password: String) {
        NetworkManager.shared.signup(username: username, email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.isAuthenticated = true
                    self.username = username
                }
            }, receiveValue: { })
            .store(in: &cancellables)
    }
    
    func logout() {
        NetworkManager.shared.logout()
        isAuthenticated = false
        username = ""
    }
}
