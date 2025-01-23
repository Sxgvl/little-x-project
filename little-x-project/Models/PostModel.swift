//
//  PostModel.swift
//  little-x-project
//
//  Created by Segal GBENOU on 23/01/2025.
//

import Foundation

struct PostModel {
//    let id: UUID
    var author: UserModel
    var likes: [LikeModel] // Stocke les ID des likes
    var title: String
    var content: String
}
