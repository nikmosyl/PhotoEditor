//
//  TextFieldWithTitle.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import SwiftUI

struct TextFieldWithTitle: View {
    @Binding var text: String
    //@FocusState private var fieldIsFocused: Bool
    @State private var isHide: Bool = true
    
    let title: String
    let placeholder: String
    let onSubmit: () -> Void
    let height: CGFloat
    let cornerRadius: CGFloat
    let fontSize: CGFloat
    let labelTextColor: Color
    let textColor: Color
    let placeholderColor: Color
    let backgroundColor: Color
    let borderColor: Color
    let isHiddeble: Bool
    
    var field: some View {
        Group {
            if isHide && isHiddeble {
                SecureField(
                    "",
                    text: $text,
                    prompt: Text(placeholder).foregroundColor(placeholderColor)
                )
            } else {
                TextField(
                    "",
                    text: $text,
                    prompt: Text(placeholder).foregroundColor(placeholderColor)
                )
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundStyle(labelTextColor)
                
                Spacer()
            }
            
            HStack{
                field
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
                    .font(Font.system(size: fontSize).weight(.medium))
                    .foregroundStyle(textColor)
                    .padding(.horizontal, height/2)
                    .submitLabel(.done)
                    //.focused($fieldIsFocused)
                    .onSubmit {
                        onSubmit()
                        //fieldIsFocused = false
                    }
                
                if isHiddeble {
                    Button(action: { isHide.toggle() }) {
                        Image(systemName: isHide ? "eye.slash" : "eye")
                            .foregroundColor(placeholderColor)
                    }
                    .padding(.horizontal, height/2)
                }
            }
            .frame(height: height)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
    }
}

#Preview {
    TextFieldWithTitle(
        text: .constant("text"),
        title: "title",
        placeholder: "placeholder",
        onSubmit: {},
        height: 30,
        cornerRadius: 12,
        fontSize: 30,
        labelTextColor: .red,
        textColor: .green,
        placeholderColor: .yellow,
        backgroundColor: .blue,
        borderColor: .red,
        isHiddeble: true
    )
}
