//
//  LoginViewModel.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import Foundation

final class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""

    @Published var shouldRememberMe: Bool = false
    @Published var isAllertPresented: Bool = false
    @Published var alertMessage: String = ""
    
    func login() async -> Bool {
        do {
            try await AuthService.shared.signInUser(
                email: email,
                password: password,
                remember: shouldRememberMe
            )
            
            return true
        } catch {
            await MainActor.run {
                alertMessage = "\(error.localizedDescription)"
                isAllertPresented = true
            }
            return false
        }
    }
    
    @MainActor
    func loginWithGoogle() async -> Bool {
        do {
            try await AuthService.shared.signInWithGoogle()
            
            return true
        } catch {
            alertMessage = error.localizedDescription
            isAllertPresented = true
            return false
        }
    }
}
