//
//  CropCorner.swift
//  PhotoEditor
//
//  Created by nikita on 02.05.2025.
//

import SwiftUI

struct CropCorner: View {
    @State var position: CGSize
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
                        position = position
                        dragOffset = .zero
                    }
            )
    }
}

#Preview {
    CropCorner(position: .zero)
}
