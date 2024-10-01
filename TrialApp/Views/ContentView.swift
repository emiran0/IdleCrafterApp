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
        if authViewModel.isAuthenticated {
            MainTabView()
                .environmentObject(authViewModel)
                .environmentObject(categoryViewModel)
        } else {
            AuthenticationView()
                .environmentObject(authViewModel)
        }
    }
}


#Preview {
    ContentView()
}
