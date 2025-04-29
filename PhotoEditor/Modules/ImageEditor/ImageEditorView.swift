//
//  ImageEditorView.swift
//  PhotoEditor
//
//  Created by nikita on 28.04.2025.
//

import SwiftUI

struct ImageEditorView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var imageData: Data
    
    @ObservedObject private var viewModel: ImageEditorViewModel
    
    init(imageData: Binding<Data>) {
        self._imageData = imageData
        self.viewModel = ImageEditorViewModel(imageData: imageData.wrappedValue)
    }
    
    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()
            
            Image(uiImage: UIImage(data: imageData) ?? UIImage())
                .resizable()
                .scaledToFit()
            
            VStack {
                Spacer()
                
                toolsBar
                    .padding()
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                        Text("SAVE")
                    }
                    .tint(.secondaryButtonTitle)

                }
            }
        }
    }
    
    var toolsBar: some View {
        HStack {
            Button {
                imageData = viewModel.rotateImage(.left) ?? Data()
            } label: {
                Image(systemName: "rotate.left")
            }
            
            Button {
                imageData = viewModel.rotateImage(.right) ?? Data()
            } label: {
                Image(systemName: "rotate.right")
            }
            
            Spacer()
        }
        .tint(.secondaryButtonTitle)
    }
}


#Preview {
    if let image = UIImage(named: "photoExample") {
        if let imageData = image.jpegData(compressionQuality: 1) {
            ImageEditorView(imageData: .constant(imageData))
        }
    }
}
