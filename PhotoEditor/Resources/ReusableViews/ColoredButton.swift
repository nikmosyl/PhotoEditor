//
//  ColoredButton.swift
//  PhotoEditor
//
//  Created by nikita on 26.04.2025.
//

import SwiftUI

struct ButtonProperty {
    let backgroundColor: Color
    let textColor: Color
}

enum ButtonType {
    case primary
    case secondary
    
    var properties: ButtonProperty {
        switch self {
        case .primary:
            ButtonProperty(backgroundColor: .buttonBackground, textColor: .buttonTitle)
        case .secondary:
            ButtonProperty(backgroundColor: .secondaryButtonBackground, textColor: .secondaryText)
        }
    }
}

struct ColoredButton: View {
    let label: String
    let type: ButtonType
    let icon: Image?
    let closure: () -> Void
    
    var body: some View {
        Button {
            closure()
        } label: {
            HStack {
                icon?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 26, height: 26)
                
                Text(label)
                    .font(.body)
                    .foregroundStyle(type.properties.textColor)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(type.properties.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
