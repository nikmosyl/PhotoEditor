//
//  CropRectangle.swift
//  PhotoEditor
//
//  Created by nikita on 02.05.2025.
//

import Foundation

struct CropRectangle {
    var upperLeft = CGSize(width: -50, height: -50) {
        willSet {
            print("upperLeft willSet")
            upperRight.height = newValue.height
            lowerLeft.width = newValue.width
        }
    }
    
    var upperRight = CGSize(width: 50, height: -50)
    {
        willSet {
            print("upperRight willSet")
            upperLeft.height = newValue.height
            lowerRight.width = newValue.width
        }
    }
    
    var lowerLeft = CGSize(width: -50, height: 50)
    {
        willSet {
            print("lowerLeft willSet")
            lowerRight.height = newValue.height
            upperLeft.width = newValue.width
        }
    }
    
    var lowerRight = CGSize(width: 50, height: 50)
    {
        willSet {
            print("lowerRight willSet")
            lowerLeft.height = newValue.height
            upperRight.width = newValue.width
        }
    }
}
