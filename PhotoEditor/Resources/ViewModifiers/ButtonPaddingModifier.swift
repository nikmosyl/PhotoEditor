//
//  TextFieldStyleModifier.swift
//  PhotoEditor
//
//  Created by nikita on 26.04.2025.
//

import SwiftUI

struct ButtonPaddingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 55)
    }
}

extension View {
    func buttonPadding() -> some View {
        modifier(ButtonPaddingModifier())
    }
}
