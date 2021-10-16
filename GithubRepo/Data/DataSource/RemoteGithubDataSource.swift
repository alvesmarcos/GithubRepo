//
//  RemoteGithubDataSource.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

class RemoteGithubDataSource: GithubDataSource {
    private let service: GithubFetcher

    init(service: GithubFetcher = RemoteGithubFetcher()) {
        self.service = service
    }

    func getRepositories(with query: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        service.fetchRepositories(with: query) { response in
            switch response {
            case .success(let searchRepositoriesResponse):
                let repositories = searchRepositoriesResponse.items.map { RepositoryResponseMapper.map($0) }
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
