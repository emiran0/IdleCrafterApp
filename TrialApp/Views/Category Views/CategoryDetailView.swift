//
//  CategoryDetailView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Views/CategoryDetailView.swift

import SwiftUI
import Combine

struct CategoryDetailView: View {
    let categoryName: String
    @EnvironmentObject var viewModel: CategoryViewModel
    @State private var selectedTool: ToolData?
    @State private var timerCancellable: AnyCancellable?

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
                Section(header: Text("Tools").foregroundColor(.primary).fontWeight(.bold)) {
                    ForEach(getTools(for: categoryName)) { tool in
                        Button(action: {
                            self.selectedTool = tool
                        }) {
                            HStack(alignment: .center) {
                                Image(tool.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .padding(8)
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(Color(.lightGray))
                                            .padding(6)
                                    )
                                VStack(alignment: .leading) {
                                    Text(tool.displayName)
                                        .foregroundColor(.primary)
                                        .font(.title)
                                    Text("Tier \(tool.tier ?? 1)")
                                        .foregroundColor(.secondary)
                                        .font(.subheadline)
                                }
                                Spacer()
                                
                                Text(tool.isOccupied ?? false ? "Occupied" : "Available")
                                    .foregroundColor(tool.isOccupied ?? false ? .red : .green)
                                    .font(.subheadline)
                            }
                            .padding(.horizontal, -10) // Adjust for List row padding
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(maxWidth: .infinity)
                    }
                }

                Section(header: Text("Items").foregroundColor(.primary).fontWeight(.bold)) {
                    ForEach(getItems(for: categoryName)) { item in
                        HStack {
                            Image(item.iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(8)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color(.lightGray))
                                        .padding(14)
                                )
                            VStack(alignment: .leading) {
                                Text(item.itemDisplayName)
                                    .foregroundColor(.primary)
                                Text("Quantity: \(item.itemQuantity)")
                                    .foregroundColor(.secondary)
                                    .font(.subheadline)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, -10)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .sheet(item: $selectedTool) { tool in
                ToolDetailView(tool: tool)
                    .environmentObject(viewModel)
            }
        }
        .background(Color(UIColor.systemBackground))
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func startTimer() {
        timerCancellable = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                viewModel.fetchData()
            }
    }

    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
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
        case "farming":
            return "iconFarm"
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
