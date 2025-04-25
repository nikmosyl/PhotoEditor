//
//  LoginView.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("Login")
                .font(Font.system(size: 30))
            
            Spacer()
            
            placeTextField(
                text: $viewModel.email,
                title: "Email",
                placeholder: "Enter your email adress",
                onSubmit: { print("done") },
                isHiddeble: false
            )
            
            placeTextField(
                text: $viewModel.password,
                title: "Password",
                placeholder: "Enter your password",
                onSubmit: {},
                isHiddeble: true
            )
            
            Button("Login") {
                Task {
                    await viewModel.login()
                }
            }
            
            Spacer()
            
            HStack {
                Text("Don't have an account?")
                
                Button("Sign Up") {
                    print("go to Sign UP")
                }
            }
        }
        .padding()
        .alert(isPresented: $viewModel.isAllertPresented) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("ОК"))
            )
        }
    }
    
    private func placeTextField (
        text: Binding<String>,
        title: String,
        placeholder: String,
        onSubmit: @escaping () -> Void,
        isHiddeble: Bool
    ) -> some View {
        TextFieldWithTitle(
            text: text,
            title: title,
            placeholder: placeholder,
            onSubmit: onSubmit,
            height: 32,
            cornerRadius: 12,
            fontSize: 20,
            labelTextColor: .green,
            textColor: .red,
            placeholderColor: .yellow,
            backgroundColor: .gray,
            borderColor: .red,
            isHiddeble: isHiddeble
        )
    }
}

#Preview {
    LoginView()
}
