//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Views/MainTabView.swift

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    @State private var selectedIndex: Int = 2

    var body: some View {
        TabView(selection: $selectedIndex) {
            InfoView()
                .tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("Info")
                }
                .tag(0)

            ChatView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chat")
                }
                .tag(1)

            CategoryView()
                .tabItem {
                    Image(systemName: "rectangle.grid.1x2.fill")
                    Text("Categories")
                }
                .tag(2)

            MarketView()
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Market")
                }
                .tag(3)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
        .tint(.red)
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = .systemBackground
        })
    }
}

struct MarketView: View {
    var body: some View {
        Text("Market Screen")
            .font(.largeTitle)
            .padding()
    }
}

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel

    var body: some View {
        VStack {

            // Other profile details...

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
        }
        .padding()
    }
}

struct ChatView: View {
    var body: some View {
        Text("Chat Screen")
            .font(.largeTitle)
            .padding()
    }
}

struct InfoView: View {
    var body: some View {
        Text("Info Screen")
            .font(.largeTitle)
            .padding()
    }
}
