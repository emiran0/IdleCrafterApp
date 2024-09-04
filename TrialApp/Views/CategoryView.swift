//
//  CategoryView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 30.08.2024.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var iconName : String
    var level : Int
    var progressValue: Float
    var destinationView: AnyView
    var action: () -> Void
    var body: some View {
        NavigationLink(destination: destinationView){
                HStack(alignment: .center, spacing: 25) {
                    Image(iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .padding(.leading, 5)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(text)
                            .font(.custom("Audiowide-Regular", size: 28))
                            .foregroundStyle(Color.white)
                            .fixedSize(horizontal: false, vertical: true)
                        HStack{
                            Text("LEVEL \(level)")
                                .font(.custom("Audiowide-Regular", size: 14))
                                .foregroundStyle(Color.white)
                            Spacer()
                            Text("251 XP")
                                .font(.custom("Audiowide-Regular", size: 14))
                                .foregroundStyle(Color.white)
                        }
                        ProgressBar(value: progressValue)
                            .frame(height: 12)
                    }
                }
                .padding(5)
                .frame(height: 75)
                .cornerRadius(20)
            
        }
    }
}

struct ProgressBar: View {
    var value: Float  // Progress value between 0.0 and 1.0

    var body: some View {
        ZStack(alignment: .topTrailing) {
                    GeometryReader { geometry in
                        Rectangle()
                            .foregroundColor(.white.opacity(0.5)) // Background color of the progress bar
                            .frame(width: geometry.size.width*0.98, height: 12) // Adjusted height
                            .cornerRadius(5)
                        
                        Rectangle()
                            .foregroundColor(Color(red: 25/255, green: 29/255, blue: 44/255)) // Color of the progress
                            .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width)) // Adjusted height
                            .cornerRadius(5)
                            .animation(.linear, value: value)
                    }
                
                }
    }
}


struct CategoryView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 12) {
                CustomButton(
                    text: "MINING",
                    iconName: "iconMine",
                    level: 3,
                    progressValue: 0.75, // 50% progress
                    destinationView: AnyView(MiningView()),
                    action: {
                        print("Button 1 tapped")
                    }
                )
                .background(Color(red: 129/255, green: 129/255, blue: 129/255)) // Apply color dynamically
                .cornerRadius(12)
                .padding(.top, 10)
                .padding(.horizontal, 8)
                
                CustomButton(
                    text: "CRAFTING",
                    iconName: "iconCraft",
                    level: 3,
                    progressValue: 0.55,
                    destinationView: AnyView(MiningView()),
                    action: {
                        print("Button 2 tapped")
                    }
                )
                .background(Color.orange) // Apply color dynamically
                .cornerRadius(12)
                .padding(.horizontal, 8)
                
                CustomButton(
                    text: "FARMING",
                    iconName:"iconFarm",
                    level: 3,
                    progressValue: 0.75,
                    destinationView: AnyView(MiningView()),
                    action: {
                        print("Button 3 tapped")
                    }
                )
                .background(Color(red: 213/255, green: 152/255, blue: 96/255)) // Apply color dynamically
                .cornerRadius(12)
                .padding(.horizontal, 8)
                
                CustomButton(
                    text: "WOODCUTTING",
                    iconName:"iconWood",
                    level: 3,
                    progressValue: 0.35,
                    destinationView: AnyView(MiningView()),
                    action: {
                        print("Button 3 tapped")
                    }
                )
                .background(Color.green)
                .cornerRadius(12)
                .padding(.horizontal, 8)
                
                CustomButton(
                    text: "ALCHEMY",
                    iconName:"iconAlchemy",
                    level: 3,
                    progressValue: 0.65,
                    destinationView: AnyView(MiningView()),
                    action: {
                        print("Button 3 tapped")
                    }
                )
                .background(Color.indigo)
                .cornerRadius(12)
                .padding(.horizontal, 8)
                
                CustomButton(
                    text: "FISHING",
                    iconName:"iconFish",
                    level: 3,
                    progressValue: 0.95,
                    destinationView: AnyView(MiningView()),
                    action: {
                        print("Button 3 tapped")
                    }
                )
                .background(Color.pink)
                .cornerRadius(12)
                .padding(.horizontal, 8)
                
                CustomButton(
                    text: "COOKING",
                    iconName:"iconCook",
                    level: 3,
                    progressValue: 0.15,
                    destinationView: AnyView(MiningView()),
                    action: {
                        print("Button 3 tapped")
                    }
                )
                .background(Color.purple)
                .cornerRadius(12)
                .padding(.horizontal, 8)
                
                CustomButton(
                    text: "COMBAT",
                    iconName:"iconCombat",
                    level: 3,
                    progressValue: 0.25,
                    destinationView: AnyView(MiningView()),
                    action: {
                        print("Button 3 tapped")
                    }
                )
                .background(Color.brown)
                .cornerRadius(12)
                .padding(.bottom, 10)
                .padding(.horizontal, 8)
                Spacer()
                //            CustomButton(
                //                text: "Button 3",
                //                iconName:"iconMine",
                //                level: 3,
                //                progressValue: 0.75,
                //                action: {
                //                    print("Button 3 tapped")
                //                }
                //            )
                //                .background(Color.purple)
                //                .cornerRadius(12)
            }
            .background(Color(red: 26/255, green: 26/255, blue: 26/255))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
}

