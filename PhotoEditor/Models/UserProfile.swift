//
//  UserProfile.swift
//  PhotoEditor
//
//  Created by nikita on 25.04.2025.
//

import Foundation

struct UserProfile: Codable {
    let uid: String
    var nickname: String
    var photo: Data?
    var images: [Data]?
}
