//
//  ContentView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 21.08.2024.
//

import SwiftUI

struct MarketView: View {
    var body: some View {
        Text("Market Screen")
            .font(.largeTitle)
            .padding()
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile Screen")
            .font(.largeTitle)
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


struct ContentView: View {
    @State private var selectedIndex: Int = 2
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        TabView(selection: $selectedIndex){
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
                .background(Color(red: 26/255, green: 26/255, blue: 26/255))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            MarketView()
                .tabItem {
                    Image(systemName: "cart").accentColor(.green)
                    Text("Market")
                        .foregroundColor(.green)
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                        .renderingMode(.template)
                    Text("Profile")
                }
                .tag(4)
                
        }
        .onChange(of: scenePhase) {
            if scenePhase == .background {
                print("App is going to the background")
//                MiningManager.shared.saveMinedMaterials()
            }
        }
        .tint(.red)
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = .systemBackground
        })
    }
}

#Preview {
    ContentView()
        .environmentObject(GameManager.shared)
}
