//
//  ContentView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 21.08.2024.
// ContentView.swift

import SwiftUI

struct ContentView: View {
    @StateObject private var authViewModel = AuthenticationViewModel()
    @StateObject private var categoryViewModel = CategoryViewModel()
    
    var body: some View {
        Group{
            if authViewModel.isAuthenticated {
                MainTabView()
                    .environmentObject(authViewModel)
                    .environmentObject(categoryViewModel)
            } else {
                AuthenticationView()
                    .environmentObject(authViewModel)
            }
        }
        .alert(isPresented: $authViewModel.showErrorAlert) {
            Alert(
                title: Text("Session Expired"),
                message: Text(authViewModel.errorMessage ?? "Please log in again."),
                dismissButton: .default(Text("OK")) {
                    // Reset error message and alert flag if needed
                    authViewModel.errorMessage = nil
                    authViewModel.showErrorAlert = false
                }
            )
        }
    } 
}


#Preview {
    ContentView()
}
