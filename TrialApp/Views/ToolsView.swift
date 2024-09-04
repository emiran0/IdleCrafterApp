//
//  ToolsView.swift
//  TrialApp
//
//  Created by Emiran Kartal on 3.09.2024.
//

//import SwiftUI
//
//struct Toola: Identifiable {
//    let id: UUID = UUID()
//    let name: String
//    let iconName: String
//    let status: Int
//}
//
//struct ToolsView: View {
//    @State private var selectedTool: Tool?
//    
//    // Now using Tool struct instead of String
//    let tools = [Tool(name: "Pickaxe", iconName: "toolIconPickaxe", status: 1),
//                 Tool(name: "Furnace", iconName: "toolIconFurnace", status: 1),
//                 Tool(name: "Oil Extractor", iconName: "toolIconOilExtractor", status: 1),
//                 Tool(name: "Drill", iconName: "toolIconDrill", status: 0)]
//    
//    var body: some View {
//        GeometryReader { geometry in
//            VStack(spacing:10) {
//                Text("TOOLS")
//                    .font(.custom("Audiowide-Regular", size: 22))
//                    .foregroundStyle(Color.white)
//                    .frame(maxWidth:.infinity, alignment: .leading)
//                    
//                ForEach(tools) { tool in
//                    Button(action: {
//                        self.selectedTool = tool
//                    }) {
//                        HStack{
//                            Image(tool.iconName)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 30, height: 30)
//                                .padding(10)
//                                .background(Color.blue)
//                                .cornerRadius(10)
//                            Text(tool.name)
//                                .font(.custom("Audiowide-Regular", size: 18))
//                                .foregroundStyle(Color.white)
//                            Spacer()
//                            
//                            Text(tool.status == 0 ? "IDLE" : "WORKING")
//                                .font(.custom("Audiowide-Regular", size: 10))
//                                .foregroundColor(tool.status == 0 ? .yellow : .green)
//                                .padding()
//                        }
//                            .frame(width: geometry.size.width * 0.95, height: 45)
//                            .background(.gray)
//                        
//                        
//                    }
//                        
//                }
//            }
//            .padding(12)
//            .frame(width: widthForTools(count: tools.count, totalWidth: geometry.size.width))
//            .background(Color(red: 129/255, green: 129/255, blue: 129/255))
//            .cornerRadius(15)
//        }
//        .sheet(item: $selectedTool) { tool in
//                    self.formView(for: tool)
//        }
//    }
//    
//    @ViewBuilder
//    private func formView(for tool: Tool) -> some View {
//        switch tool.name {
//        case "Pickaxe":
//            HammerFormView()
//        case "Furnace":
//            WrenchFormView()
//        case "Oil Extractor":
//            ScrewdriverFormView()
//        default:
//            Text("No form available for \(tool.name)")
//        }
//    }
//    
//    func widthForTools(count: Int, totalWidth: CGFloat) -> CGFloat {
//        // Adjust width based on the number of tools
//        return totalWidth
//    }
//}
//
//struct HammerFormView: View {
//    @EnvironmentObject var miningManager: MiningManager
//    var body: some View {
//        
//        NavigationView{
//            List {
//                ForEach(miningManager.minedMaterials.keys.sorted(), id: \.self) { key in
//                    HStack {
//                        Text(key).bold()
//                        Spacer()
//                        Text("\(miningManager.minedMaterials[key] ?? 0)")
//                    }
//                }
//            }
//            .navigationBarTitle("Minded Items")
//        }
//    }
//}
//
//struct WrenchFormView: View {
//    var body: some View {
//        Text("Form for Wrench")
//    }
//}
//struct ScrewdriverFormView: View {
//    var body: some View {
//        Text("Form for Screwdriver")
//    }
//}
