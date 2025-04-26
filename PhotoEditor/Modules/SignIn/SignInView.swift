//
//  LoginView.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @FocusState var keyboardIsAppear: Bool
    @StateObject private var viewModel = SignInViewModel()
    
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
                
                VStack(spacing: 36) {
                    ColoredButton(
                        label: "SIGN IN",
                        type: .primary,
                        icon: nil
                    ) {
                        Task {
                            await viewModel.login()
                        }
                    }
                    
                    if !keyboardIsAppear {
                        Text("OR")
                            .foregroundStyle(.secondaryText)
                        
                        ColoredButton(
                            label: "Login with Google",
                            type: .secondary,
                            icon: Image(.googleIcon)
                        ) {
                            Task {
                                await viewModel.login()
                            }
                        }
                    }
                }
                .padding(.horizontal, 55)
                .padding(.top, 36)
                
                Spacer()
                
                if !keyboardIsAppear {
                    HStack {
                        Text("Don't have an account?")
                        
                        Button {
                            coordinator.signUp()
                        } label: {
                            Text("Sign Up")
                                .foregroundStyle(.secondaryButtonTitle)
                        }
                        
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
            .focused($keyboardIsAppear)
        }
    }
}

#Preview {
    SignInView()
}
