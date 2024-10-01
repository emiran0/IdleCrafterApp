//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Views/CustomButton.swift

import SwiftUI

struct CustomButton<Destination: View>: View {
    var text: String
    var iconName: String
    var level: Int
    var progressValue: Float
    var destinationView: Destination

    var body: some View {
        NavigationLink(destination: destinationView) {
            HStack(alignment: .center, spacing: 25) {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .padding(.leading, 5)

                VStack(alignment: .leading, spacing: 2) {
                    Text(text)
                        .font(.custom("Audiowide-Regular", size: 28))
                        .foregroundColor(Color.primary)
                        .fixedSize(horizontal: false, vertical: true)
                    HStack {
                        Text("LEVEL \(level)")
                            .font(.custom("Audiowide-Regular", size: 14))
                            .foregroundColor(Color.secondary)
                        Spacer()
                        Text("\(Int(progressValue * 100))% XP")
                            .font(.custom("Audiowide-Regular", size: 14))
                            .foregroundColor(Color.secondary)
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
