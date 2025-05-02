//
//  ImageEditorView.swift
//  PhotoEditor
//
//  Created by nikita on 28.04.2025.
//

import SwiftUI

struct ImageEditorView: View {
    @Environment(\.dismiss) var dismiss
    @State var cropRect = CGRect(x: 0, y: 0, width: 200, height: 200)
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
            
            VStack {
                Spacer()
                
                ZStack {
                    Image(uiImage: UIImage(data: imageData) ?? UIImage())
                        .resizable()
                        .scaledToFit()
                    
                    CropRectangle()
                }
                
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
    @Previewable @State var image = (UIImage(named: "photoExample") ?? UIImage()).jpegData(compressionQuality: 1) ?? Data()
    
    ImageEditorView(imageData: $image)
}
