//
//  InfoView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 3.10.2024.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    Text("What is ")
                        .font(.title)
                        .foregroundStyle(Color.primary)
                    Text("IDLECRAFTER?")
                        .font(.custom("Audiowide-Regular", size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.red)
                        .padding(.horizontal, -5)
                }
                
                Text("IdleCrafter is a resource management and crafting game where you gather, craft, and progress across categories like Mining, Farming, Woodcutting, Fishing, Alchemy, Cooking, and Combat. Build tools, gather resources, and optimize your gameplay to keep things running while you’re away. \n\nLevel up, unlock powerful tools, and craft advanced items to boost efficiency. Whether you’re mining rare ores or brewing potions, each category offers unique challenges and rewards. Dive into the world of IdleCrafter and become the ultimate crafter!")
                    .foregroundStyle(Color.primary)
                    .lineSpacing(6)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondary.opacity(0.3))
                            .padding(10)
                    )
                
                HStack(spacing: 10) {
                    NavigationLink(destination: HowToGuideView()) {
                        Text("How To Guide")
                            .font(.custom("Audiowide-Regular", size: 20))
                            .foregroundStyle(Color.primary)
                            .padding(10)
                            .background(Color.red)
                            .cornerRadius(4)
                    }
                    
                    NavigationLink(destination: ItemsView()) {
                        Text("Items")
                            .font(.custom("Audiowide-Regular", size: 20))
                            .foregroundStyle(Color.primary)
                            .padding(10)
                            .background(Color.red)
                            .cornerRadius(4)
                    }
                    
                    NavigationLink(destination: ToolsView()) {
                        Text("Tools")
                            .font(.custom("Audiowide-Regular", size: 20))
                            .foregroundStyle(Color.primary)
                            .padding(10)
                            .background(Color.red)
                            .cornerRadius(4)
                    }
                }
                
                Spacer()
                
                Text("IdleCrafter © 2024")
                    .font(.custom("Audiowide-Regular", size: 12))
                    .foregroundStyle(Color.primary)
                    .padding(.bottom, 10)
            }
        }
    }
}




