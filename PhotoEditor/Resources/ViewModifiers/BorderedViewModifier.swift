//
//  BorderedViewModifier.swift
//  PhotoEditor
//
//  Created by nikita on 26.04.2025.
//

import SwiftUI

struct BorderedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.border)
            )
    }
}

extension View {
    func bordered() -> some View {
        modifier(BorderedViewModifier())
    }
}
