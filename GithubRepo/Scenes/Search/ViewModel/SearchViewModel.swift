//
//  SearchViewModel.swift
//  GithubRepo
//
//  Created by Marcos Alves on 09/10/21.
//

import Foundation
import RxRelay
import RxSwift

class SearchViewModel: ViewModelSearching {
    // MARK: - Attributes

    private let disposeBag = DisposeBag()
    private var githubRepository: GithubRepository
    private(set) var repositoryCellViewModels: BehaviorRelay<[RepositoryCellViewModel]>
    private(set) var state: BehaviorRelay<FetchState>
    private weak var coordinator: SearchCoordinator?

    // MARK: - Constructors

    init(coordinator: SearchCoordinator, repository: GithubRepository = GithubMainRepository()) {
        self.coordinator = coordinator
        self.repositoryCellViewModels = BehaviorRelay(value: [])
        self.state = BehaviorRelay(value: .inital)
        self.githubRepository = repository

        self.bind()
    }

    // MARK: - Methods

    func fetchRepositories(query: String) {
        githubRepository.fetchRepositories(with: query)
    }

    private func bind() {
        githubRepository.state.subscribe(onNext: {
            self.onChangeState(state: $0)
        })
        .disposed(by: disposeBag)
        githubRepository.repositories.subscribe(onNext: {
            self.onChangeRepositories(repos: $0)
        })
        .disposed(by: disposeBag)
    }
}

// MARK: - Handle Notifications from Repository

extension SearchViewModel {
    private func onChangeState(state: FetchState) {
        self.state.accept(state)
    }

    private func onChangeRepositories(repos: [Repository]) {
        let repositoriesCell = repos.map { RepositoryCellViewModel(repository: $0) }
        self.repositoryCellViewModels.accept(repositoriesCell)
    }
}
