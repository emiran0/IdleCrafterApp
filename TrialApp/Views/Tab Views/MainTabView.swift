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
                .environmentObject(categoryViewModel)

            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
        .tint(.red)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground

            // Set unselected item tint color to adapt to Light and Dark Mode
            UITabBar.appearance().unselectedItemTintColor = UIColor.label
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}


struct ChatView: View {
    var body: some View {
        Text("Chat Screen")
            .font(.largeTitle)
            .padding()
    }
}


