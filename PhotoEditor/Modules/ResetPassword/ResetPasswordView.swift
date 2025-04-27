//
//  ResetPasswordView.swift
//  PhotoEditor
//
//  Created by nikita on 26.04.2025.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject private var viewModel = ResetPasswordViewModel()
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                HStack {
                    Button {
                        coordinator.back()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundStyle(.text)
                    }
                    
                    Text("Reset password")
                    
                    Spacer()
                }
                .font(.title)
                
                Text("Please enter your email to request a password reset")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                PrimaryTextField(
                    text: $viewModel.email,
                    placeholder: "Enter your email"
                )
                .textFieldStyleModifier(iconName: "envelope")
                
                ColoredButton(
                    label: "SEND",
                    type: .primary,
                    icon: nil
                ) {
                    Task {
                        if await viewModel.resetPassword() {
                            coordinator.signIn()
                        }
                    }
                }
                .buttonPadding()
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $viewModel.isAllertPresented) {
                Alert(
                    title: Text("Message"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("ОК"))
                )
            }
        }
    }
}

#Preview {
    ResetPasswordView()
}
