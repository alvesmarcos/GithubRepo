//
//  SearchViewModel.swift
//  GithubRepo
//
//  Created by Marcos Alves on 09/10/21.
//

import Foundation

class SearchViewModel: ViewModelSearching {
    // MARK: - Attributes

    private var githubRepository: GithubRepository
    private(set) var repositoryCellViewModels: [RepositoryCellViewModel]
    private(set) var loading: Bool
    private(set) var error: Bool
    private weak var coordinator: SearchCoordinator?
    weak var delegate: SearchViewModelDelegate?

    // MARK: - Constructors

    init(coordinator: SearchCoordinator, repository: GithubRepository = GithubMainRepository()) {
        self.coordinator = coordinator
        self.repositoryCellViewModels = []
        self.loading = false
        self.error = false
        self.githubRepository = repository
        self.githubRepository.delegate = self
    }

    // MARK: - Methods

    func fetchRepositories(query: String) {
        githubRepository.fetchRepositories(with: query)
    }
}

// MARK: - Notifications from Repository

extension SearchViewModel: GithubRepositoryDelegate {
    func didChangeLoading(loading: Bool) {
        self.loading = loading
        self.delegate?.onChangeSearchLoadingState(isLoading: loading)
    }

    func didChangeRepositories(repositories: [Repository]) {
        self.repositoryCellViewModels = repositories.map { RepositoryCellViewModel(repository: $0) }
        self.delegate?.onChangeSearchRepository(repoCellViewModels: self.repositoryCellViewModels)
    }

    func didChangeError(error: Bool) {
        self.error = error
        self.delegate?.onChangeSearchError(error: error)
    }
}
