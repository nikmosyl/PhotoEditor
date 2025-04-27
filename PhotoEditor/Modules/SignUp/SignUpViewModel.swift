//
//  SignUpViewModel.swift
//  PhotoEditor
//
//  Created by nikita on 26.04.2025.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var nikname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirm: String = ""
    
    @Published var processing: Bool = false
    
    @Published var isAllertPresented: Bool = false
    var alertMessage: String = ""
    
    private func valideteTextFields() -> Bool {
        let emailPattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        let passwordPattern = #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailPattern)
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        
        if !emailPredicate.evaluate(with: email) {
            alertMessage = "Enter a valid email"
            return false
        }
        
        if !passwordPredicate.evaluate(with: password) {
            alertMessage = "The password must be at least 8 characters long and contain at least one letter and one number"
            return false
        }
        
        if password != passwordConfirm {
            alertMessage = "Passwords don't match"
            return false
        }
        
        return true
    }
    
    @MainActor
    func signUp() async -> Bool {
        guard valideteTextFields() else {
            isAllertPresented = true
            return false
        }
        
        processing = true
        
        do {
            try await AuthService.shared.registerUser(
                email: email,
                password: password,
                nickname: nikname
            )
            
            try await AuthService.shared.signInUser(
                email: email,
                password: password
            )
            processing = false
            return true
        } catch {
            alertMessage = "\(error.localizedDescription)"
            processing = false
            isAllertPresented = true
            return false
        }
    }
}
