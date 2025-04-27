//
//  LoadingView.swift
//  PhotoEditor
//
//  Created by nikita on 27.04.2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            ForEach(0..<12) { i in
                Capsule()
                    .fill(Color.buttonBackground)
                    .frame(width: 6, height: 18)
                    .opacity(Double(i) / 12.0)
                    .offset(y: -30)
                    .rotationEffect(.degrees(Double(i) / 12 * 360))
            }
        }
        //.frame(width: 100, height: 100)
        .rotationEffect(.degrees(360))
        .animation(
            Animation.linear(duration: 1)
                .repeatForever(autoreverses: false),
            value: true
        )
    }
}

#Preview {
    LoadingView()
}
