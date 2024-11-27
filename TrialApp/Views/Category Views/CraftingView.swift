//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Views/CraftingView.swift

import SwiftUI

struct CraftingView: View {
    @StateObject private var viewModel = CraftingViewModel()
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack {
                    CategoryTopBoxView(
                        Title: "Crafting",
                        iconName: "iconCraft",
                        level: 4,
                        progressValue: 0.7)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal, 12)
                    
                    List(viewModel.craftableTools) { tool in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(tool.displayName)
                                    .font(.headline)
                                    .foregroundColor(Color.primary)
                                Text("Tool Tier: \(tool.tier)")
                                    .foregroundStyle(Color.primary)
                                    .padding(8)
                                    .font(.subheadline)
                                Spacer()
                                Text("\(tool.category)")
                                    .foregroundStyle(Color.primary)
                                    .padding(8)
                                    .font(.subheadline)
                            }
                            ForEach(tool.requiredItems) { item in
                                HStack {
                                    Text(item.itemDisplayName)
                                        .foregroundColor(Color.secondary)
                                    Spacer()
                                    Text("x\(item.requiredQuantity)")
                                        .foregroundColor(Color.secondary)
                                }
                                .font(.subheadline)
                            }
                            HStack{
                                Spacer()
                                Button(action: {
                                    viewModel.craftTool(toolUniqueName: tool.uniqueToolName, toolTier: tool.tier)
                                }) {
                                    Text("Craft")
                                        .foregroundStyle(Color.primary)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 5)
                                        .background(.blue)
                                        .cornerRadius(6)
                                }
                                .padding(.top, 5)
                                Spacer()
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .listStyle(PlainListStyle())
                }
                
            }
        }
        .onAppear {
            viewModel.fetchCraftableTools()
        }
        .navigationTitle("Crafting")
        .background(Color(UIColor.systemBackground))
        .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Crafting"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
    }
}
