//
//  CategoryDetailView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Views/CategoryDetailView.swift

import SwiftUI

struct CategoryDetailView: View {
    let categoryName: String
    @EnvironmentObject var viewModel: CategoryViewModel
    @State private var selectedTool: ToolData?

    var body: some View {
        VStack(alignment: .leading) {
            CategoryTopBoxView(
                Title: categoryName.uppercased(),
                iconName: getIconName(for: categoryName),
                level: getCategoryLevel(),
                progressValue: getCategoryProgress()
            )
            .background(Color.gray)
            .cornerRadius(12)
            .padding(.horizontal, 12)

            List {
                Section(header: Text("Tools").foregroundColor(.primary)) {
                    ForEach(getTools(for: categoryName)) { tool in
                        Button(action: {
                            self.selectedTool = tool
                        }) {
                            HStack {
                                Text(tool.displayName)
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("Tier \(tool.tier ?? 1)")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }

                Section(header: Text("Items").foregroundColor(.primary)) {
                    ForEach(getItems(for: categoryName)) { item in
                        ItemRow(item: item)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .sheet(item: $selectedTool) { tool in
                ToolDetailView(tool: tool)
                    .environmentObject(viewModel)
            }
        }
        .navigationBarTitle(categoryName, displayMode: .inline)
        .background(Color(UIColor.systemBackground))
    }

    private func getTools(for category: String) -> [ToolData] {
        return viewModel.tools.filter { $0.uniqueToolName.lowercased().contains(category.lowercased()) }
    }

    private func getItems(for category: String) -> [ItemData] {
        return viewModel.items.filter { $0.itemUniqueName.lowercased().contains(category.lowercased()) }
    }

    private func getIconName(for category: String) -> String {
        switch category.lowercased() {
        case "mining":
            return "iconMine"
        case "crafting":
            return "iconCraft"
        case "woodcutting":
            return "iconWood"
        // Add other cases
        default:
            return "defaultIcon"
        }
    }

    private func getCategoryLevel() -> Int {
        // Implement logic
        return 1
    }

    private func getCategoryProgress() -> Float {
        // Implement logic
        return 0.5
    }
}

struct ItemRow: View {
    let item: ItemData
    
    var body: some View {
        HStack {
            Text(item.itemDisplayName)
                .foregroundColor(.white)
            Spacer()
            Text("Qty: \(item.itemQuantity)")
                .foregroundColor(.white)
        }
        .contentShape(Rectangle())
    }
}
