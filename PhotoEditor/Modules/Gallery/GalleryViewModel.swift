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
    
    @MainActor
    func fetchUserProfile() async {
        processing = true
        
        guard let currentUser = await AuthService.shared.getCurrentUser() else {
            return
        }
        
        userProfile = currentUser
        
        processing = false
    }
}
