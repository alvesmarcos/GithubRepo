//
//  GithubSearchable.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

protocol GithubFetcher {
    func fetchRepositories(with query: String, completion: @escaping(Result<SearchRepoResponse, Error>) -> Void)
}
