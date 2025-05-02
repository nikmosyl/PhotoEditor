//
//  CropRectangle.swift
//  PhotoEditor
//
//  Created by nikita on 02.05.2025.
//

import SwiftUI

struct CropRectangleView: View {
    @State var corner = CropRectangle()
    
    var body: some View {
        CropCorner(position: corner.upperLeft)
        CropCorner(position: corner.upperRight)
        CropCorner(position: corner.lowerLeft)
        CropCorner(position: corner.lowerRight)
    }
}

#Preview {
    @Previewable @State var cropRect: CGRect = CGRect(
        origin: .zero,
        size: CGSize(width: 100, height: 100)
    )
    
    CropRectangleView()
}
