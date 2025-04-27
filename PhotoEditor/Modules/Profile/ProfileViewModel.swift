//
//  ProfileViewModel.swift
//  PhotoEditorцццццццццццццц
//
//  Created by nikita on 27.04.2025.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile
    
    @Published var processing: Bool = false
    
    @Published var isAllertPresented: Bool = false
    var alertMessage: String = ""
    var alertTitle: String = ""
    
    init() {
        userProfile = UserProfile(uid: "0", nickname: "empty")
    }
    
    @MainActor
    func fetchUserProfile() async {
        processing = true
        
        guard let currentUser = await AuthService.shared.getCurrentUser() else {
            return
        }
        
        userProfile = currentUser
        
        processing = false
    }
    
    @MainActor
    func saveUserProfile() async {
        processing = true
        
        do {
            try await AuthService.shared.saveUserProfile(user: userProfile)
            alertTitle = "Success"
            alertMessage = "Save complete"
        } catch {
            alertTitle = "Error"
            alertMessage = "\(error.localizedDescription)"
        }
        
        processing = false
        isAllertPresented = true
    }
    
    func logout() {
        try? AuthService.shared.signOut()
    }
}
