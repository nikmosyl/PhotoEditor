//
//  LoadingView.swift
//  PhotoEditor
//
//  Created by nikita on 27.04.2025.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.background.opacity(0.01)
                .ignoresSafeArea()
                .background(
                    Material.ultraThin // Полупрозрачный фон с матовым эффектом
                )
            
            ForEach(0..<12) { i in
                Capsule()
                    .fill(Color.buttonBackground)
                    .frame(width: 6, height: 18)
                    .opacity(Double(i) / 12.0)
                    .offset(y: -30)
                    .rotationEffect(.degrees(Double(i) / 12 * 360))
            }
            .frame(width: 100, height: 100)
            .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
            .animation(
                Animation.linear(duration: 1)
                    .repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
        }
    }
}

#Preview {
    LoadingView()
}
