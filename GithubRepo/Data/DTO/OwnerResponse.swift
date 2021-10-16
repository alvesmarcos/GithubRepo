//
//  OwnerResponse.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

struct OwnerResponseMapper: DataMapper {
    static func map(_ data: OwnerResponse) -> Owner {
        Owner(id: data.id, name: data.login, avatar: URL(string: data.avatarUrl))
    }
}

struct OwnerResponse: Decodable {
    let id: Int64
    let login: String
    let avatarUrl: String

    private enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case id, login
    }
}
