//
//  GithubMainRepository.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation
import RxRelay
import RxSwift

class GithubMainRepository: GithubRepository {
    private let dataSource: GithubDataSource
    private(set) var repositories: BehaviorRelay<[Repository]>
    private(set) var state: BehaviorRelay<FetchState>

    init(dataSource: GithubDataSource = RemoteGithubDataSource()) {
        self.dataSource = dataSource
        self.repositories = BehaviorRelay<[Repository]>(value: [])
        self.state = BehaviorRelay<FetchState>(value: .inital)
    }

    func handleChangeRepositories(_ repo: [Repository]) {
        self.repositories.accept(repo)
    }

    func handleChangeState(_ state: FetchState) {
        self.state.accept(state)
    }

    func fetchRepositories(with query: String) {
        handleChangeState(.loading)
        self.dataSource.getRepositories(with: query) { [weak self] response in
            switch response {
            case .success(let repositoriesResponse):
                self?.handleChangeRepositories(repositoriesResponse)
                self?.handleChangeState(repositoriesResponse.isEmpty ? .empty: .content)
            case .failure:
                self?.handleChangeState(.error)
            }
        }
    }
}
