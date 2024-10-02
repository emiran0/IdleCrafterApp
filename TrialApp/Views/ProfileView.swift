//  TrialApp
//
//  Created by Emiran Kartal on 2.10.2024.
//
// Views/ProfileView.swift

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else if let profile = viewModel.userProfile {
                Text("Profile")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text("Welcome, \(profile.username)!")
                    .font(.title2)
                    .padding()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Email: \(profile.email)")
                    Text("Gold: \(profile.gold, specifier: "%.0f")")
                    Text("Energy: \(profile.energy, specifier: "%.0f")")
                }
                .padding()

                Spacer()

                // Logout Button
                Button(action: {
                    authViewModel.logout()
                }) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding()
            } else {
                Text("No profile data available.")
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchUserProfile()
        }
    }
}
