//
//  ImageEditorViewModel.swift
//  PhotoEditor
//
//  Created by nikita on 28.04.2025.
//

import Foundation
import UIKit

enum RotateDirection {
    case left
    case right
}

final class ImageEditorViewModel: ObservableObject {
    @Published var rotationAngle: Double = 0
    
    private var image: UIImage
    
    init(imageData: Data) {
        self.image = UIImage(data: imageData) ?? UIImage()
    }
    
    func rotateImage(_ direction: RotateDirection) -> Data? {
        let angle: CGFloat = direction == .left ? -.pi / 2 : .pi / 2
        
        var newSize = CGRect(
            origin: CGPoint.zero,
            size: image.size
        ).applying(CGAffineTransform(rotationAngle: angle)).size
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        context.rotate(by: angle)
        image.draw(
            in: CGRect(
                x: -image.size.width/2,
                y: -image.size.height/2,
                width: image.size.width,
                height: image.size.height
            )
        )
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        
        image = newImage
        
        return getImageData()
    }
    
    
    
    func getImageData() -> Data? {
        image.jpegData(compressionQuality: 1.0)
    }
}
