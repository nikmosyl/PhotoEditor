//
//  ProfileViewModel.swift
//  PhotoEditorцццццццццццццц
//
//  Created by nikita on 27.04.2025.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    @Published var isAllertPresented: Bool = false
    var alertMessage: String = ""
    var alertTitle: String = ""
    
    init() {
        userProfile = UserProfile(
            uid: "0",
            nickname: "empty",
            photo: Data()
        )
    }
    
    func fetchUserProfile() async {
        guard let currentUser = await AuthService.shared.getCurrentUser() else {
            return
        }
        
        await MainActor.run {
            userProfile = currentUser
        }
    }
    
    func saveUserProfile() async {
        do {
            try await AuthService.shared.saveUserProfile(user: userProfile)
            alertTitle = "Success"
            alertMessage = "Save complete"
        } catch {
            alertTitle = "Error"
            alertMessage = "\(error.localizedDescription)"
        }
        
        await MainActor.run {
            isAllertPresented = true
        }
    }
    
    func logout() {
        try? AuthService.shared.signOut()
    }
}
