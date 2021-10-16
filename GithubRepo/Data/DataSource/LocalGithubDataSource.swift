//
//  LocalGithubDataSource.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

class LocalGithubDataSource: GithubDataSource {
    let service: GithubFetcher
    
    init(service: GithubFetcher = LocalGithubFetcher()) {
        self.service = service
    }
    
    func getRepositories(with query: String, completion: @escaping (Result<[RepositoryResponse], Error>) -> Void) {
        service.fetchRepositories(with: query) { response in
            switch response {
            case .success(let searchRepositoriesResponse):
                completion(.success(searchRepositoriesResponse.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
