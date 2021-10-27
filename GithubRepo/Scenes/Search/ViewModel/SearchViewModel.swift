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

        self.bindRepository()
    }

    // MARK: - Methods

    func fetchRepositories(query: String) {
        githubRepository.fetchRepositories(with: query)
    }

    private func bindRepository() {
        githubRepository.state
            .bind(to: self.state)
            .disposed(by: disposeBag)
        githubRepository.repositories
            .map({ repos in
               repos.map { RepositoryCellViewModel(repository: $0) }
            })
            .bind(to: self.repositoryCellViewModels)
            .disposed(by: disposeBag)
    }
}
