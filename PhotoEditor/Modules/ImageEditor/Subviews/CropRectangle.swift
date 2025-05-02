//
//  CropRectangle.swift
//  PhotoEditor
//
//  Created by nikita on 02.05.2025.
//

import SwiftUI

struct CropRectangle: View {
    @State var position = CGSize.zero
    @State var dragOffset = CGSize.zero
    
    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 10, height: 10)
            .offset(x: position.width + dragOffset.width,
                    y: position.height + dragOffset.height)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { value in
                        position.width += value.translation.width
                        position.height += value.translation.height
                        dragOffset = .zero
                    }
            )
    }
}

#Preview {
    @Previewable @State var cropRect: CGRect = CGRect(
        origin: .zero,
        size: CGSize(width: 100, height: 100)
    )
    
    CropRectangle()
}
