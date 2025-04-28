//
//  TextFieldStyleModifier.swift
//  PhotoEditor
//
//  Created by nikita on 26.04.2025.
//

import SwiftUI

struct TextFieldStyleModifier: ViewModifier {
    let iconName: String
    
    func body(content: Content) -> some View {
        content
            .leadingIcon(
                icon: Image(systemName: iconName),
                size: 20,
                color: .secondaryText
            )
            .bordered()
    }
}

extension View {
    func textFieldStyleModifier(iconName: String) -> some View {
        modifier(TextFieldStyleModifier(iconName: iconName))
    }
}
