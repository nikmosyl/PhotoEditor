//
//  LoginView.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Spacer()
                
                HStack {
                    Text("Sign In")
                        .font(.title)
                    Spacer()
                }
                
                PrimaryTextField(
                    text: $viewModel.email,
                    placeholder: "Enter your email"
                )
                .textFieldStyleModifier(iconName: "envelope")
                
                HiddebleTextField(
                    text: $viewModel.password,
                    placeholder: "Enter your password"
                )
                .textFieldStyleModifier(iconName: "lock")
                
                HStack {
                    Toggle(isOn: $viewModel.shouldRememberMe) {}
                        .labelsHidden()
                        .tint(.buttonBackground)
                    
                    Text("Remember Me")
                        .foregroundColor(.secondaryText)
                    
                    Spacer()
                    
                    Button {
                        coordinator.resetPassword()
                    } label: {
                        Text("Forgot password?")
                            .tint(.secondaryText)
                    }
                    
                }
                
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
    }
}

#Preview {
    LoginView()
}
