//
//  MiningView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 3.09.2024.
//

import SwiftUI

struct MiningView: View {
    @ObservedObject var gameManager = GameManager.shared
    var body: some View {
        VStack(alignment: .leading){
            CategoryTopBoxView(Title: "MINING",
                               iconName: "iconMine",
                               level: 3,
                               progressValue: 0.40)
                .background(Color(red: 129/255, green: 129/255, blue: 129/255))
                .cornerRadius(12)
            Spacer()
//            ToolsView()
            templateView()
                .background(Color(red: 26/255, green: 26/255, blue: 26/255))
//            ToolsView()
//                .background(Color(red: 26/255, green: 26/255, blue: 26/255))
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 26/255, green: 26/255, blue: 26/255))
    }
}

struct templateView: View{
    @ObservedObject var gameManager = GameManager.shared
    
    var body: some View {
        List(gameManager.items, id: \.id) { item in
            ItemView(item: item)
        }
    }
}

struct ItemView: View {
    @ObservedObject var item: Item  // Observe individual item

    var body: some View {
        HStack {
            Image(systemName: "person.fill")
            Text("\(item.itemName): \(item.itemCount)")
                .onAppear {
                    print("Item \(item.itemName), count: \(item.itemCount)")
                }
        }
    }
}

//struct ToolsView: View {
//    @ObservedObject var gameManager = GameManager.shared
//
//    var body: some View {
//        List {
//            ForEach(gameManager.tools) { tool in
//                ToolView(tool: tool)
//            }
//        }
//    }
//}
//
//struct ToolView: View {
//    let tool: Tool
//
//    var body: some View {
//        HStack {
//            Text("Tool \(tool.status)")
//            Spacer()
//            Button(action: {
//                tool.toggleStatus()
//            }) {
//                Image(systemName: tool.status == 1 ? "pause.circle.fill" : "play.circle.fill")
//                    .foregroundColor(tool.status == 1 ? .green : .red)
//            }
//        }
//    }
//}

