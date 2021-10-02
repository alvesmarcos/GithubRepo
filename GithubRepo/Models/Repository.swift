//
//  Repository.swift
//  GithubRepo
//
//  Created by Marcos Alves on 29/09/21.
//

import Foundation

struct Repository: Codable {
    let id: Int64
    let name: String
    let description: String
    let language: String
    let forks: Int
    let stars: Int
    let owner: Owner
    
    private enum CodingKeys: String, CodingKey {
        case stars = "watchers"
        case id, name, description, language, forks, owner
    }
}
