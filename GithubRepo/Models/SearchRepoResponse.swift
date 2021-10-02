//
//  SearchRepoResponse.swift
//  GithubRepo
//
//  Created by Marcos Alves on 29/09/21.
//

import Foundation

struct SearchRepoResponse: Codable {
    let totalCount: Int64
    let incompleteResults: Bool
    let items: [Repository]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
