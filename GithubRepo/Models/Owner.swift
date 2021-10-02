//
//  Owner.swift
//  GithubRepo
//
//  Created by Marcos Alves on 29/09/21.
//

import Foundation

struct Owner: Codable {
    let id: Int64
    let login: String
    let avatarUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case id, login
    }
}
