//
//  ImagePicker.swift
//  PhotoEditor
//
//  Created by nikita on 27.04.2025.
//

import SwiftUI

struct ImagePicker: View {
    var pickFromGallery: () -> Void
    var takePhoto: () -> Void
    
    var body: some View {
        VStack {
            ColoredButton(
                label: "PickFrom Gallery",
                type: .primary,
                icon: Image(systemName: "photo.badge.plus"),
                closure: pickFromGallery
            )
            
            ColoredButton(
                label: "Take Photo",
                type: .primary,
                icon: Image(systemName: "person.crop.square.badge.camera"),
                closure: takePhoto
            )
        }
        .tint(.buttonTitle)
        .bordered()
    }
}

#Preview {
    ImagePicker {
        print("pickFromGallery")
    } takePhoto: {
        print("takePhoto")
    }
}
