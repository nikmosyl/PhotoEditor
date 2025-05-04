//
//  CropRectangle.swift
//  PhotoEditor
//
//  Created by nikita on 02.05.2025.
//

import SwiftUI

struct CropRectangleView: View {
    @State var dragOffsetUL = CGSize.zero
    @State var dragOffsetUR = CGSize.zero
    @State var dragOffsetLL = CGSize.zero
    @State var dragOffsetLR = CGSize.zero
    
    @State var top = CGSize(width: 0, height: -50)
    @State var bottom = CGSize(width: 0, height: 50)
    @State var leading = CGSize(width: -50, height: 0)
    @State var trailing = CGSize(width: 50, height: 0)
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
                .offset(x: leading.width + dragOffsetUL.width,
                        y: top.height + dragOffsetUL.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffsetUL = value.translation
                            dragOffsetUR.height = value.translation.height
                            dragOffsetLL.width = value.translation.width
                        }
                        .onEnded { value in
                            leading.width += value.translation.width
                            top.height += value.translation.height
                            dragOffsetUL = .zero
                            dragOffsetUR = .zero
                            dragOffsetLL = .zero
                        }
                )
            
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
                .offset(x: trailing.width + dragOffsetUR.width,
                        y: top.height + dragOffsetUR.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffsetUR = value.translation
                            dragOffsetUL.height = value.translation.height
                            dragOffsetLR.width = value.translation.width
                        }
                        .onEnded { value in
                            trailing.width += value.translation.width
                            top.height += value.translation.height
                            dragOffsetUR = .zero
                            dragOffsetUL = .zero
                            dragOffsetLR = .zero
                        }
                )
            
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
                .offset(x: leading.width + dragOffsetLL.width,
                        y: bottom.height + dragOffsetLL.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffsetLL = value.translation
                            dragOffsetLR.height = value.translation.height
                            dragOffsetUL.width = value.translation.width
                        }
                        .onEnded { value in
                            leading.width += value.translation.width
                            bottom.height += value.translation.height
                            dragOffsetLL = .zero
                            dragOffsetLR = .zero
                            dragOffsetUL = .zero
                        }
                )
            
            Circle()
                .fill(Color.red)
                .frame(width: 10, height: 10)
                .offset(x: trailing.width + dragOffsetLR.width,
                        y: bottom.height + dragOffsetLR.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffsetLR = value.translation
                            dragOffsetLL.height = value.translation.height
                            dragOffsetUR.width = value.translation.width
                        }
                        .onEnded { value in
                            trailing.width += value.translation.width
                            bottom.height += value.translation.height
                            dragOffsetLR = .zero
                            dragOffsetLL = .zero
                            dragOffsetUR = .zero
                        }
                )
        }
    }
}

#Preview {
    @Previewable @State var cropRect: CGRect = CGRect(
        origin: .zero,
        size: CGSize(width: 100, height: 100)
    )
    
    CropRectangleView()
}
