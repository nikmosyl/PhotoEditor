//
//  LeadingIconViewModifier.swift
//  PhotoEditor
//
//  Created by nikita on 26.04.2025.
//

import SwiftUI

struct LeadingIconViewModifier: ViewModifier {
    let icon: Image
    let iconSize: CGFloat
    let iconColor: Color
    
    func body(content: Content) -> some View {
        HStack {
            icon
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: iconSize, height: iconSize)
                .foregroundStyle(iconColor)
            
            content
        }
        
    }
}

extension View {
    func leadingIcon(icon: Image, size: CGFloat, color: Color) -> some View {
        modifier(LeadingIconViewModifier(icon: icon, iconSize: size, iconColor: color))
    }
}
