//
//  NavigationCoordinator.swift
//  PhotoEditor
//
//  Created by nikita on 26.04.2025.
//

import Foundation

enum Screen {
    case signIn
    case signUp
    case resetPassword
    case gallery
    case profile
}

class NavigationCoordinator: ObservableObject {
    @Published var currentScreen: Screen = .signIn {
        didSet {
            previousScreen = oldValue
        }
    }
    private var previousScreen: Screen = .signIn
    
    func back() {
        currentScreen = previousScreen
    }
    
    func loggedIn() {
        currentScreen = .gallery
    }
    
    func resetPassword() {
        currentScreen = .resetPassword
    }
    
    func signUp() {
        currentScreen = .signUp
    }
    
    func signIn() {
        currentScreen = .signIn
    }
    
    func logOut() {
        currentScreen = .signIn
    }
    
    func showProfile() {
        currentScreen = .profile
    }
}
