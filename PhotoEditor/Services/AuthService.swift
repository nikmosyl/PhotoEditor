//
//  AuthService.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import GoogleSignIn

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
        GIDSignIn.sharedInstance.signOut()
    }
    
    func sendPasswordReset(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func getCurrentUser() async -> UserProfile? {
        guard let userId = auth.currentUser?.uid else { return nil }
        
        do {
            let userProfile = try await fetchUserProfile(userId: userId)
            return userProfile
        } catch {
            return nil
        }
    }
    
    @MainActor
    func signInWithGoogle() async throws -> UserProfile {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw NSError(domain: "GoogleAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing client ID"])
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let rootViewController = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .first(where: { $0.isKeyWindow })?
            .rootViewController else {
            throw NSError(domain: "GoogleAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "No root view controller"])
        }
        
        let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        
        let idToken = userAuthentication.user.idToken?.tokenString
        let accessToken = userAuthentication.user.accessToken.tokenString
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken ?? "", accessToken: accessToken)
        
        let result = try await Auth.auth().signIn(with: credential)
        let user = result.user
        
        let userId = user.uid
        do {
            return try await fetchUserProfile(userId: userId)
        } catch {
            let nameComponents = user.displayName?.split(separator: " ") ?? []
            let firstName = nameComponents.first.map(String.init) ?? "User"
            
            let profile = UserProfile(
                uid: userId,
                nickname: firstName
            )
            try await saveUserProfile(user: profile)
            return profile
        }
    }
}
