//
//  ProfileView.swift
//  PhotoEditor
//
//  Created by nikita on 27.04.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background).ignoresSafeArea()
                
                VStack {
                    HStack {
                        
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        coordinator.back()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundStyle(.text)
                            .font(.title)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
