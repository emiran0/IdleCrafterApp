//  TrialApp
//
//  Created by Emiran Kartal on 1.10.2024.
//
// Views/ProgressBar.swift

import SwiftUI

struct ProgressBar: View {
    var value: Float  // Progress value between 0.0 and 1.0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.white.opacity(0.5))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .cornerRadius(5)

                Rectangle()
                    .foregroundColor(Color(red: 25/255, green: 29/255, blue: 44/255))
                    .frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .cornerRadius(5)
                    .animation(.linear, value: value)
            }
        }
    }
}
