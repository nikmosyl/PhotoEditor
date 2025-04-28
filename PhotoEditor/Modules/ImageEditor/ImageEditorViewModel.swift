//
//  ImageEditorViewModel.swift
//  PhotoEditor
//
//  Created by nikita on 28.04.2025.
//

import Foundation

enum RotateDirection {
    case left
    case right
}

final class ImageEditorViewModel: ObservableObject {
    @Published var scale: CGFloat = 1.0
    @Published var rotation: Double = 0.0
    @Published var isControlsVisible: Bool = false
    
    func rotate(_ direction: RotateDirection) {
        switch direction {
        case .left:
            rotation -= 90
        case .right:
            rotation += 90
        }
    }
}
