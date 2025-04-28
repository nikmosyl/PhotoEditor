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
    
    @Published var processing: Bool = false
    
    @Published var isAllertPresented: Bool = false
    var alertMessage: String = ""
    
    @MainActor
    func login() async -> Bool {
        processing = true
        
        let result: Bool
        
        do {
            try await AuthService.shared.signInUser(
                email: email,
                password: password,
                remember: shouldRememberMe
            )
            result = true
        } catch {
            alertMessage = "\(error.localizedDescription)"
            result = false
        }
        
        processing = false
        isAllertPresented = !result
        return result
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
