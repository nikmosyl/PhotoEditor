//
//  SignUp.swift
//  PhotoEditor
//
//  Created by nikita on 26.04.2025.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @FocusState private var keyboardIsActive: Bool
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Spacer()
                
                Text("Sign Up")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                PrimaryTextField(
                    text: $viewModel.nikname,
                    placeholder: "Enter you nikname"
                )
                .textFieldStyleModifier(iconName: "person")
                
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
                
                HiddebleTextField(
                    text: $viewModel.passwordConfirm,
                    placeholder: "Repeat your password"
                )
                .textFieldStyleModifier(iconName: "lock")
                
                Spacer()
                
                ColoredButton(
                    label: "SIGN UP",
                    type: .primary,
                    icon: nil
                ) {
                    Task {
                        await viewModel.signUp()
                    }
                }
                .padding(.horizontal, 55)
                
                Spacer()
                
                if !keyboardIsActive {
                    HStack {
                        Text("Don't have an account?")
                            .foregroundStyle(.secondaryText)
                        
                        Button {
                            coordinator.signIn()
                        } label: {
                            Text("Sign In")
                                .foregroundStyle(.secondaryButtonTitle)
                        }
                    }
                }
            }
            .padding()
            .focused($keyboardIsActive)
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
    SignUpView()
}
