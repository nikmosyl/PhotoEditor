//
//  ResetPasswordViewModel.swift
//  PhotoEditor
//
//  Created by nikita on 26.04.2025.
//

import Foundation

final class ResetPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isAllertPresented: Bool = false
    var alertTitle: String = ""
    var alertMessage: String = ""
    
    private func valideteEmail() -> Bool {
        let emailPattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailPattern)
        
        if !emailPredicate.evaluate(with: email) {
            alertMessage = "Enter a valid email"
            return false
        }
        
        return true
    }
    
    func resetPassword() async -> Bool {
        guard valideteEmail() else {
            await MainActor.run {
                isAllertPresented = true
            }
            return false
        }
        
        do {
            try await AuthService.shared.sendPasswordReset(email: email)
            alertTitle = "Done"
            alertMessage = "Password reset email sent to \(email)"
            await MainActor.run {
                isAllertPresented = true
            }
        } catch {
            alertTitle = "Error"
            alertMessage = "\(error.localizedDescription)"
            await MainActor.run {
                isAllertPresented = true
            }
            return false
        }
        
        return true
    }
}
