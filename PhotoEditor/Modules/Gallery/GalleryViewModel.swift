//
//  GalleryViewModel.swift
//  PhotoEditor
//
//  Created by nikita on 27.04.2025.
//

import Foundation

final class GalleryViewModel: ObservableObject {
    @Published var userProfile: UserProfile = UserProfile(uid: "", nickname: "")
    @Published var imagesData: [Data] = []
    
    @Published var processing: Bool = false
    
    @Published var isAllertPresented: Bool = false
    var alertMessage: String = ""
    
    init() {
        Task {
            await fetchUserProfile()
        }
    }
    
    @MainActor
    func fetchUserProfile() async {
        processing = true
        
        guard let currentUser = await AuthService.shared.getCurrentUser() else {
            return
        }
        
        userProfile = currentUser
        imagesData = userProfile.images ?? []
        
        processing = false
    }
    
    @MainActor
    func addImage(data: Data) async {
        imagesData.append(data)
        userProfile.images = imagesData
        
        await saveGallery()
    }
    
    @MainActor
    func saveGallery() async {
        processing = true
        
        if userProfile.uid.isEmpty { return }
        
        do {
            try await AuthService.shared.saveUserProfile(user: userProfile)
        } catch {
            alertMessage = "\(error.localizedDescription)"
            isAllertPresented = true
        }
        
        processing = false
    }
}
