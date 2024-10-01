//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Views/ToolDetailView.swift

import SwiftUI

struct ToolDetailView: View {
    let tool: ToolData
    @StateObject private var viewModel = ToolDetailViewModel()
    @EnvironmentObject var categoryViewModel: CategoryViewModel // Access to items

    var body: some View {
        VStack(alignment: .leading) {
            Text(tool.displayName)
                .font(.largeTitle)
                .padding(.bottom, 5)

            Text("Tier: \(tool.tier ?? 1)")
                .padding(.bottom, 5)

            Text("Status: \(tool.isEnabled == true ? "Enabled" : "Disabled")")
                .padding(.bottom, 10)

            if tool.isOccupied == true {
                // Show ongoing crafting
                if let ongoingItemUniqueName = tool.ongoingCraftingItemUniqueName,
                   let remainingQuantity = tool.ongoingRemainedQuantity {
                    // Get the item's display name from categoryViewModel.items
                    let ongoingItemDisplayName = categoryViewModel.items.first(where: { $0.itemUniqueName == ongoingItemUniqueName })?.itemDisplayName ?? ongoingItemUniqueName

                    VStack(alignment: .leading, spacing: 5) {
                        Text("Currently Crafting:")
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text("Item: \(ongoingItemDisplayName)")
                        Text("Remaining Quantity: \(remainingQuantity)")
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.bottom, 10)
                }
            }

            if viewModel.isLoading {
                ProgressView("Loading recipes...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else if let recipes = viewModel.toolRecipes?.recipeList, !recipes.isEmpty {
                // Display craftable items
                List(recipes) { craftableItem in
                    VStack(alignment: .leading) {
                        Text(craftableItem.outputItemDisplayName)
                            .font(.headline)
                            .foregroundColor(Color.primary)
                        Text("Generation Duration: \(craftableItem.generationDuration) seconds")
                            .font(.subheadline)
                            .foregroundColor(Color.secondary)
                        Text("Required Items:")
                            .font(.subheadline)
                            .foregroundColor(Color.primary)
                        ForEach(craftableItem.inputItems) { inputItem in
                            HStack {
                                Text(inputItem.inputItemDisplayName)
                                Spacer()
                                Text("x\(inputItem.inputItemQuantity)")
                            }
                            .foregroundColor(Color.secondary)
                        }
                        HStack {
                            TextField("Quantity", text: Binding(
                                get: { viewModel.desiredQuantities[craftableItem.id, default: "1"] },
                                set: { viewModel.desiredQuantities[craftableItem.id] = $0 }
                            ))
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                            Button(action: {
                                if let quantityString = viewModel.desiredQuantities[craftableItem.id],
                                   let quantity = Int(quantityString), quantity > 0 {
                                    viewModel.craftItem(itemUniqueName: craftableItem.outputItemUniqueName, quantity: quantity)
                                }
                            }) {
                                Text("Craft")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.top, 5)
                    }
                    .padding(.vertical, 5)
                }
                .listStyle(PlainListStyle())
            } else if tool.isRepeating == true {
                // Repeating tool
                Text("This is a repeating tool.")
                    .foregroundColor(Color.secondary)
                // Additional functionality for repeating tools can be added here
            } else {
                Text("No craftable items available for this tool.")
                    .foregroundColor(Color.secondary)
            }

            Spacer()
        }
        .padding()
        .onAppear {
            if tool.isRepeating == false {
                viewModel.fetchItemCraftingRecipes(for: tool.uniqueToolName)
            }
        }
        .alert(isPresented: $viewModel.showCraftSuccess) {
            Alert(title: Text("Success"), message: Text("Item crafted successfully."), dismissButton: .default(Text("OK")))
        }
    }
}
