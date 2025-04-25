//
//  AuthService.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import Foundation
import FirebaseAuth
import FirebaseDatabaseInternal


final class AuthService {
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    private let database = Database.database().reference()
    
    private init() {}
    
    func saveUserProfile(user: UserProfile) async throws {
        let userData = try JSONEncoder().encode(user)
        let userDataDictionary = try JSONSerialization.jsonObject(with: userData, options: []) as? [String: Any]
        
        try await database.child("users").child(user.uid).setValue(userDataDictionary)
    }
    
    func fetchUserProfile(userId: String) async throws -> UserProfile {
        let snapshot = try await database.child("users").child(userId).getData()
        
        guard let data = snapshot.value as? [String: Any] else {
            throw NSError(
                domain: "DataError",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Incorrect data"]
            )
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
        let userProfile = try JSONDecoder().decode(UserProfile.self, from: jsonData)
        
        return userProfile
    }
    
    func registerUser(email: String, password: String, nickname: String) async throws -> UserProfile {
        let authResult = try await auth.createUser(withEmail: email, password: password)
        
        let userId = authResult.user.uid
        let userProfile = UserProfile(uid: userId, nickname: nickname)
        
        try await saveUserProfile(user: userProfile)
        
        return userProfile
    }
    
    func signInUser(email: String, password: String) async throws -> UserProfile {
        let authResult = try await auth.signIn(withEmail: email, password: password)
        let userId = authResult.user.uid
        
        return try await fetchUserProfile(userId: userId)
    }
    
    func signOut() throws {
        try auth.signOut()
    }
}
