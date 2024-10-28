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
    @Published var showErrorAlert: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Check if token exists
        isAuthenticated = NetworkManager.shared.token != nil
        NotificationCenter.default.publisher(for: .didReceiveUnauthorized)
                    .sink { [weak self] _ in
                        self?.handleUnauthorized()
                    }
                    .store(in: &cancellables)
    }
    
    func handleUnauthorized() {
            // Perform logout actions
            DispatchQueue.main.async {
                if self.isAuthenticated {
                    self.isAuthenticated = false
                    self.token = nil
                    self.errorMessage = "Session expired. Please log in again."
                    self.showErrorAlert = true
                }
            }
        }
    
    func login(username: String, password: String) {
            NetworkManager.shared.login(username: username, password: password)
                .receive(on: DispatchQueue.main)  // Ensure updates happen on the main thread
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        // Handle error
                        self.errorMessage = self.parseError(error)
                        self.showErrorAlert = true  // Trigger the alert
                        print("Login failed: \(self.errorMessage ?? error.localizedDescription)")
                    case .finished:
                        break
                    }
                }, receiveValue: { _ in
                    // Login successful
                    self.isAuthenticated = true
                    self.errorMessage = nil
                    self.showErrorAlert = false
                })
                .store(in: &cancellables)
        }

        private func parseError(_ error: Error) -> String {
            // Attempt to parse the error message from the server
            if let urlError = error as? URLError, let data = urlError.userInfo[NSUnderlyingErrorKey] as? Data {
                if let apiError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                    return apiError.detail
                }
            }
            return error.localizedDescription
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
        
        // Disconnect WebSocket
        WebSocketManager.shared.disconnect()
    }
    
    var token: String? {
            get { NetworkManager.shared.token }
            set { NetworkManager.shared.token = newValue }
        }
    
}

struct APIErrorResponse: Decodable {
    let detail: String
}
