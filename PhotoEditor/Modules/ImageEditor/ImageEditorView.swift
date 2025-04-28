//
//  ImageEditorView.swift
//  PhotoEditor
//
//  Created by nikita on 28.04.2025.
//

import SwiftUI

struct ImageEditorView: View {
    @Binding var imageData: Data
    
    @StateObject private var viewModel = ImageEditorViewModel()
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            Image(uiImage: UIImage(data: imageData) ?? UIImage())
                .resizable()
                .scaledToFit()
                .scaleEffect(viewModel.scale)
                .rotationEffect(.degrees(viewModel.rotation))
            
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        viewModel.rotate(.left)
                    } label: {
                        Image(systemName: "rotate.left")
                    }
                    
                    Button {
                        viewModel.rotate(.right)
                    } label: {
                        Image(systemName: "rotate.right")
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}


#Preview {
    if let image = UIImage(named: "photoExample") {
        if let imageData = image.jpegData(compressionQuality: 1) {
            ImageEditorView.init(imageData: .constant(imageData))
        }
    }
}
