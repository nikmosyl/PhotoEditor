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
            case .home:
                Text("home")
                    .transition(.move(edge: .top))
            case .profile:
                Text("profile")
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut, value: coordinator.currentScreen)
    }
}

#Preview {
    RootView()
}
