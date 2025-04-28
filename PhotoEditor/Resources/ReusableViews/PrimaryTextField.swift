//
//  TextFieldWithTitle.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import SwiftUI

struct PrimaryTextField: View {
    @Binding var text: String
    
    let placeholder: String
    
    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder).foregroundColor(Color.secondaryText)
        )
        .autocorrectionDisabled(true)
        .keyboardType(.emailAddress)
        .submitLabel(.done)
    }
}
