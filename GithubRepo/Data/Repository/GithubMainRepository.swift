//
//  GithubMainRepository.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

class GithubMainRepository: GithubRepository {
    
    weak var delegate: GithubRepositoryDelegate?
    private var dataSource: GithubDataSource
    private(set) var repositories: [Repository]
    private(set) var loading: Bool
    private(set) var error: Bool
    
    init(dataSource: GithubDataSource = RemoteGithubDataSource()) {
        self.dataSource = dataSource
        self.repositories = []
        self.loading = false
        self.error = false
    }
    
    func handleChangeRepositories(_ repo: [RepositoryResponse]) {
        self.repositories = repo.map { RepositoryResponseMapper.map($0) }
        delegate?.didChangeRepositories()
    }
    
    func handleChangeLoading(_ loading: Bool) {
        self.loading = loading
        delegate?.didChangeLoading()
    }
    
    func handleChangeError(_ error: Bool) {
        self.error = error
        delegate?.didChangeError()
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
