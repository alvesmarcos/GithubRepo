//
//  SearchViewModel.swift
//  GithubRepo
//
//  Created by Marcos Alves on 09/10/21.
//

import Foundation

class SearchViewModel: ViewModelSearching {
    
    // MARK: - Attributes
    
    weak var delegate: SearchViewModelDelegate?
    private var githubRepository: GithubRepository
    private(set) var repositoryCellViewModels: [RepositoryCellViewModel]
    private(set) var loading: Bool
    private(set) var error: Bool
    
    // MARK: - Constructors
    
    init(repository: GithubRepository = GithubMainRepository()) {
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
    func didChangeLoading() {
        self.loading = self.githubRepository.loading
        self.delegate?.onChangeSearchLoadingState(isLoading: self.loading)
    }
    
    func didChangeRepositories() {
        self.repositoryCellViewModels = githubRepository.repositories.map { RepositoryCellViewModel(repository: $0) }
        self.delegate?.onChangeSearchRepository(repoCellViewModels: self.repositoryCellViewModels)
    }
    
    func didChangeError() {
        self.error = githubRepository.error
        self.delegate?.onChangeSearchError(error: self.error)
    }
}
