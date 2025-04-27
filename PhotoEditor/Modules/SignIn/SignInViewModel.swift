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
    
    @Published var moveToProfile: Bool = false
    @Published var isAllertPresented: Bool = false
    @Published var alertMessage: String = ""
    
    func login() async -> Bool {
        do {
            let signedInUser = try await AuthService.shared.signInUser(
                email: email,
                password: password
            )
            #warning("DEBUG")
            print("Пользователь вошел: \(signedInUser.uid) \(signedInUser.nickname)")
        } catch {
            #warning("DEBUG")
            print("Ошибка логина: \(error)")
            
            await MainActor.run {
                alertMessage = "\(error.localizedDescription)"
                isAllertPresented = true
            }
            return false
        }
        
        return true
    }
    
    @MainActor
    func loginWithGoogle() async -> Bool {
        do {
            let user = try await AuthService.shared.signInWithGoogle()
            #warning("DEBUG")
            print("Google user logged in: \(user.nickname)")
            
            return true
        } catch {
            alertMessage = error.localizedDescription
            isAllertPresented = true
            return false
        }
    }
}
