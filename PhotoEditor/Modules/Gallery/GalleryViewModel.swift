//
//  GalleryViewModel.swift
//  PhotoEditor
//
//  Created by nikita on 27.04.2025.
//

import Foundation

final class GalleryViewModel: ObservableObject {
    @Published var userProfile: UserProfile = UserProfile(uid: "", nickname: "")
    
    @Published var processing: Bool = false
    
    @Published var isAllertPresented: Bool = false
    var alertMessage: String = ""
    
    @MainActor
    func fetchUserProfile() async {
        processing = true
        
        guard let currentUser = await AuthService.shared.getCurrentUser() else {
            return
        }
        
        userProfile = currentUser
        
        processing = false
    }
    
    func addImage(data: Data) async {
        await MainActor.run {
            if userProfile.images == nil {
                userProfile.images = [data]
            } else {
                userProfile.images?.append(data)
            }
        }
        
        do {
            try await AuthService.shared.saveUserProfile(user: userProfile)
        } catch {
            alertMessage = "\(error.localizedDescription)"
            await MainActor.run {
                isAllertPresented = true
            }
        }
    }
}
