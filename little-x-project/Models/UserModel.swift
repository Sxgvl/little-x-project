//
//  UserModel.swift
//  little-x-project
//
//  Created by Segal GBENOU on 23/01/2025.
//

import Foundation

struct UserModel {
//    let id: UUID
    var userName: String
    var follows: [UserModel]
    var profileImageURL: URL?
}
