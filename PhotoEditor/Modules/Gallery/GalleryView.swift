//
//  GalleryView.swift
//  PhotoEditor
//
//  Created by nikita on 27.04.2025.
//

import SwiftUI
import PhotosUI

struct GalleryView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject private var viewModel = GalleryViewModel()
    
    @State private var selectedItem: PhotosPickerItem?
    @State var isImegaPickerPresented = false
    @State var isPhotosPickerPresented = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.background).ignoresSafeArea()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(viewModel.imagesData.enumerated()), id: \.offset) { index, imageData in
                            if let uiImage = UIImage(data: imageData) {
                                NavigationLink {
                                    ImageEditorView(imageData: Binding(
                                        get: { viewModel.imagesData[index] },
                                        set: { viewModel.imagesData[index] = $0 }
                                    ))
                                } label: {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .clipped()
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                if (viewModel.userProfile.images ?? []).isEmpty && !isImegaPickerPresented {
                    ColoredButton(
                        label: "Add Images",
                        type: .secondary,
                        icon: nil,
                        closure: { isImegaPickerPresented.toggle() }
                    )
                    .padding()
                }
                
                if isImegaPickerPresented {
                    ImagePicker {
                        isImegaPickerPresented = false
                        isPhotosPickerPresented = true
                    } takePhoto: {
                        print("take photo")
                        isImegaPickerPresented = false
                    }
                    .padding()
                }
                
                if viewModel.processing {
                    LoadingView()
                }
            }
            .onAppear() {
                Task {
                    await viewModel.saveGallery()
                }
            }
            .navigationTitle("Gallery")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isImegaPickerPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.secondaryButtonTitle)
                            .bold()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        coordinator.showProfile()
                    } label: {
                        Image(systemName: "person.fill")
                            .foregroundStyle(Color.secondaryButtonTitle)
                    }
                }
            }
            .photosPicker(
                isPresented: $isPhotosPickerPresented,
                selection: $selectedItem,
                matching: .images
            )
            .onChange(of: isPhotosPickerPresented) { _, isPresented in
                if !isPresented, let selectedItem {
                    Task {
                        if let data = try? await selectedItem.loadTransferable(type: Data.self) {
                            print("data найдена")
                            self.selectedItem = nil
                            await viewModel.addImage(data: data)
                        }
                    }
                }
            }
            .alert(isPresented: $viewModel.isAllertPresented) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("ОК"))
                )
            }
        }
    }
}

#Preview {
    GalleryView()
        .environmentObject(NavigationCoordinator())
}
