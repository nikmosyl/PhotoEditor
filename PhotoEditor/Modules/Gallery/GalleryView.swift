//
//  GalleryView.swift
//  PhotoEditor
//
//  Created by nikita on 27.04.2025.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject var coordinator: NavigationCoordinator
    @StateObject private var viewModel = GalleryViewModel()
    
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
                        ForEach(0..<20) { item in
                            Rectangle()
                                .fill(Color.buttonBackground)
                                .frame(height: 100)
                                .overlay(Text("\(item)").foregroundColor(.white))
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Gallery")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        print("add")
                    } label: {
                        Image(systemName: "photo.badge.plus")
                            .foregroundStyle(Color.secondaryButtonTitle)
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
        }
    }
}

#Preview {
    GalleryView()
        .environmentObject(NavigationCoordinator())
}
