//
//  ProfileView.swift
//  PhotoEditor
//
//  Created by nikita on 27.04.2025.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject private var viewModel = ProfileViewModel()
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background).ignoresSafeArea()
                
                VStack {
                    HStack {
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
                            Image(uiImage: UIImage(data: viewModel.userProfile.photo ?? Data()) ?? UIImage(systemName: "person.circle.fill")!)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                        }
                        .onChange(of: selectedItem) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    viewModel.userProfile.photo = data
                                }
                            }
                        }
                        
                        PrimaryTextField(
                            text: $viewModel.userProfile.nickname,
                            placeholder: "Enter ypur nikname"
                        )
                        
                        Spacer()
                    }
                    
                    
                    Spacer()
                    
                    ColoredButton(label: "SAVE", type: .primary, icon: nil) {
                        Task {
                            await viewModel.saveUserProfile()
                        }
                    }
                    .buttonPadding()
                    
                    ColoredButton(label: "LOG OUT", type: .secondary, icon: nil) {
                        viewModel.logout()
                        coordinator.logOut()
                    }
                    .buttonPadding()
                }
                .padding()
                
                if viewModel.processing {
                    LoadingView()
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
            .onAppear() {
                Task {
                    await viewModel.fetchUserProfile()
                }
            }
            .alert(isPresented: $viewModel.isAllertPresented) {
                Alert(
                    title: Text(viewModel.alertTitle),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("ОК"))
                )
            }
        }
    }
}

#Preview {
    ProfileView()
}
