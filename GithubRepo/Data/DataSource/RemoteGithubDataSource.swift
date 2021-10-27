//
//  RemoteGithubDataSource.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation
import RxSwift

class RemoteGithubDataSource: GithubDataSource {
    private let service: GithubFetcher

    init(service: GithubFetcher = RemoteGithubFetcher()) {
        self.service = service
    }

    func getRepositories(with query: String) -> Single<[Repository]> {
        return self.service.fetchRepositories(with: query)
            .map { response in
                response.1.items.map { RepositoryResponseMapper.map($0) }
            }
    }
}
