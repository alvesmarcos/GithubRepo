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
    private let disposeBag = DisposeBag()

    let repositories: BehaviorRelay<[Repository]>
    let state: BehaviorRelay<FetchState>

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
        self.handleChangeState(.loading)
        self.dataSource.getRepositories(with: query)
            .subscribe(
                onSuccess: { [weak self] in
                    self?.handleChangeRepositories($0)
                    self?.handleChangeState($0.isEmpty ? .empty: .content)
                },
                onFailure: { [weak self] _ in
                    self?.handleChangeState(.error)
                }
            )
            .disposed(by: disposeBag)
    }
}
