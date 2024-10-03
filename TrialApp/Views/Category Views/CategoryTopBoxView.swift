//  TrialApp
//
//  Created by Emiran Kartal on 3.09.2024.
//
// Views/CategoryTopBoxView.swift

import SwiftUI

struct CategoryTopBoxView: View {
    var Title: String
    var iconName: String
    var level: Int
    var progressValue: Float
    
    var body: some View {
        HStack(spacing: 25) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .padding(.leading, 5)
            VStack(alignment: .leading) {
                Text(Title)
                    .font(.custom("Audiowide-Regular", size: 30))
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Text("Level \(level)")
                        .font(.custom("Audiowide-Regular", size: 16))
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(Int(progressValue * 100))% XP")
                        .font(.custom("Audiowide-Regular", size: 16))
                        .foregroundColor(.white)
                }
                ProgressBar(value: progressValue)
                    .frame(height: 18)
            }
        }
        .padding(5)
        .frame(height: 100)
    }
}

//import SwiftUI
//
//struct CategoryTopBoxView: View {
//    var Title: String
//    var iconName : String
//    var level : Int
//    var progressValue: Float
//    var body: some View {
//        HStack(spacing: 25){
//            Image(iconName)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 70, height: 70)
//                .padding(.leading, 5)
//            VStack{
//                Text(Title)
//                    .font(.custom("Audiowide-Regular", size: 30))
//                    .foregroundStyle(Color.white)
//                Spacer()
//                HStack{
//                    Text("Level \(level)")
//                        .font(.custom("Audiowide-Regular", size: 16))
//                        .foregroundStyle(Color.white)
//                    Spacer()
//                    Text("251 XP")
//                        .font(.custom("Audiowide-Regular", size: 16))
//                        .foregroundStyle(Color.white)
//                }
//                
//                ProgressBar(value: progressValue)
//                    .frame(height: 18)
//                
//            }
//        }
//        .padding(5)
//        .frame(height: 100)
//    }
//}
