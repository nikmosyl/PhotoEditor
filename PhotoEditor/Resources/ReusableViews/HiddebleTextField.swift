//
//  TextFieldWithTitle.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import SwiftUI

struct HiddebleTextField: View {
    @Binding var text: String
    @State private var isHide: Bool = true
    
    let placeholder: String
    
    var body: some View {
        HStack{
            ZStack {
                SecureField(
                    "",
                    text: $text,
                    prompt: Text(placeholder).foregroundColor(Color.secondaryText)
                )
                .opacity(isHide ? 1 : 0)
                
                TextField(
                    "",
                    text: $text,
                    prompt: Text(placeholder).foregroundColor(Color.secondaryText)
                )
                .opacity(isHide ? 0 : 1)
            }
            .autocorrectionDisabled(true)
            .keyboardType(.emailAddress)
            .textContentType(.password)
            .submitLabel(.done)
            
            Button(
                action: {
                    isHide.toggle()
                }) {
                    Image(systemName: isHide ? "eye.slash" : "eye")
                        .foregroundColor(Color.secondaryText)
                }
        }
    }
}
