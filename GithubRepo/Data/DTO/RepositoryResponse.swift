//
//  RepositoryResponse.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

struct RepositoryResponseMapper: DataMapper {
    static func map(_ data: RepositoryResponse) -> Repository {
        Repository(
            id: data.id,
            name: data.name,
            description: data.description,
            language: data.language,
            forks: data.forks,
            stars: data.stars,
            owner: OwnerResponseMapper.map(data.owner)
        )
    }
}

struct RepositoryResponse: Decodable {
    let id: Int64
    let name: String
    let description: String?
    let language: String?
    let forks: Int
    let stars: Int
    let owner: OwnerResponse

    private enum CodingKeys: String, CodingKey {
        case stars = "watchers"
        case id, name, description, language, forks, owner
    }
}
