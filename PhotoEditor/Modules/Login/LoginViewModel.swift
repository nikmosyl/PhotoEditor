//
//  LoginViewModel.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var shouldRememberMe: Bool = false
    
    @Published var moveToProfile: Bool = false
    @Published var isAllertPresented: Bool = false
    @Published var alertMessage: String = ""
    
    func login() async {
        do {
            let signedInUser = try await AuthService.shared.signInUser(
                email: email,
                password: password
            )
            print("User sign in: \(signedInUser.uid) \(signedInUser.nickname)")
        } catch {
            print("Ошибка логина: \(error)")
            
            await MainActor.run {
                alertMessage = "\(error.localizedDescription)"
                isAllertPresented = true
            }
            return
        }
        
        await MainActor.run {
            moveToProfile = true
        }
    }
}
