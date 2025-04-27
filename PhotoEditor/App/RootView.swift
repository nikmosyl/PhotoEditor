//
//  RootView.swift
//  PhotoEditor
//
//  Created by nikita on 27.04.2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    
    var body: some View {
        ZStack {
            switch coordinator.currentScreen {
            case .signIn:
                SignInView()
                    .transition(.move(edge: .leading))
            case .signUp:
                SignUpView()
                    .transition(.move(edge: .trailing))
            case .resetPassword:
                ResetPasswordView()
                    .transition(.move(edge: .trailing))
            case .gallery:
                GalleryView()
                    .transition(.move(edge: .bottom))
            case .profile:
                ProfileView()
            }
            
            if coordinator.processing {
                LoadingView()
            }
        }
        .animation(.easeInOut, value: coordinator.currentScreen)
        .onAppear {
            Task {
                await coordinator.restoreUser()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(NavigationCoordinator())
}
