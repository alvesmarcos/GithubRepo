//
//  GithubMainRepository.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

class GithubMainRepository: GithubRepository {
    private let dataSource: GithubDataSource
    private(set) var repositories: [Repository]
    private(set) var loading: Bool
    private(set) var error: Bool
    weak var delegate: GithubRepositoryDelegate?

    init(dataSource: GithubDataSource = RemoteGithubDataSource()) {
        self.dataSource = dataSource
        self.repositories = []
        self.loading = false
        self.error = false
    }

    func handleChangeRepositories(_ repo: [Repository]) {
        self.repositories = repo
        delegate?.didChangeRepositories(repositories: repo)
    }

    func handleChangeLoading(_ loading: Bool) {
        self.loading = loading
        delegate?.didChangeLoading(loading: loading)
    }

    func handleChangeError(_ error: Bool) {
        self.error = error
        delegate?.didChangeError(error: error)
    }

    func fetchRepositories(with query: String) {
        handleChangeLoading(true)
        self.dataSource.getRepositories(with: query) { [weak self] response in
            switch response {
            case .success(let repositoriesResponse):
                self?.handleChangeRepositories(repositoriesResponse)
                self?.handleChangeLoading(false)
                self?.handleChangeError(false)
            case .failure:
                self?.handleChangeLoading(false)
                self?.handleChangeError(true)
            }
        }
    }
}
