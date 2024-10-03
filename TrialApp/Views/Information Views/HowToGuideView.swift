//
//  HowToGuideView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 3.10.2024.
//

import SwiftUI

struct HowToGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Play IdleCrafter")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundStyle(Color.primary)
                
                // First step: Creating the Pickaxe
                GuideStepView(
                    title: "Step 1: Create Your First Tool - Pickaxe",
                    description: "To start gathering resources, the first tool you need to craft is a Pickaxe. Once the Pickaxe is crafted, you can begin mining basic materials such as stones and ores.",
                    imageName: "iconMine"
                )
                
                // Mining items section
                GuideStepView(
                    title: "Step 2: Start Collecting Mining Items",
                    description: "After creating the Pickaxe, you’ll notice that mining items like stones and ores start to appear in your inventory under the 'Mining Items' category. These items will be essential for further crafting.",
                    imageName: "icon_mining_iron"
                )
                
                // Crafting a Stone Furnace
                GuideStepView(
                    title: "Step 3: Craft a Stone Furnace",
                    description: "The next important tool to craft is the Stone Furnace. This tool allows you to smelt the raw mining items into ores. Ores are a critical resource for crafting more advanced tools and items in the game.",
                    imageName: "icon_mining_furnace"
                )
                
                // Explaining further progression
                GuideStepView(
                    title: "Step 4: Expand to Other Categories",
                    description: "Once you've mastered the basics in mining, you can start exploring other categories like Farming, Woodcutting, and Alchemy. Each category functions similarly: gather items, craft tools, and progress to unlock more advanced resources and items.",
                    imageName: "iconCraft"
                )
                
                Text("The same process applies to all categories in IdleCrafter. Craft tools, gather items, and convert them into more useful resources. Level up and unlock new challenges as you become the ultimate crafter!")
                    .padding()
                    .foregroundStyle(Color.primary)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.secondary.opacity(0.2))
                            .padding(5)
                    )
            }
            .padding()
        }
        .navigationTitle("How to Play")
    }
}

struct GuideStepView: View {
    var title: String
    var description: String
    var imageName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.red)
                    .padding(.trailing, 10)
                
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.primary)
            }
            
            Text(description)
                .foregroundStyle(Color.primary)
                .lineSpacing(5)
            
            Divider()
                .padding(.vertical)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondary.opacity(0.3))
        )
    }
}
