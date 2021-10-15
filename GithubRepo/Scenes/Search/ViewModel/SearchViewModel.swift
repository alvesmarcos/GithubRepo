//
//  SearchViewModel.swift
//  GithubRepo
//
//  Created by Marcos Alves on 09/10/21.
//

import Foundation

class SearchViewModel: ViewModelSearching {
    
    // MARK: - Attributes
    
    var delegate: SearchViewModelDelegate?
    private(set) var repositoryCellViewModels: [RepositoryCellViewModel] = .init([])
    private(set) var loading: Bool = .init(false)
    private(set) var error: Bool = .init(false)
    

    // MARK: - Private Methods
    
    private func onSearchRepositoryCellUpdate(_ repo: [Repository]) {
        self.repositoryCellViewModels = repo.map { RepositoryCellViewModel(repository: $0) }
        self.delegate?.onChangeSearchRepository(repoCellViewModels: self.repositoryCellViewModels)
    }
    
    private func onSearchLoadingUpdate(_ isLoading: Bool) {
        self.loading = isLoading
        self.delegate?.onChangeSearchLoadingState(isLoading: self.loading)
    }
    
    private func onSearchErrorUpdate(_ err: Bool) {
        self.error = err
        self.delegate?.onChangeSearchError(error: self.error)
    }
    
    // MARK: - Public Methods
    
    func fetchRepositories(query: String) {
        self.onSearchLoadingUpdate(true)
        GithubFetcher.fetchRepositories(query: query) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.onSearchLoadingUpdate(false)
                self?.onSearchErrorUpdate(false)
                self?.onSearchRepositoryCellUpdate(repositories.items)
            case .failure:
                self?.onSearchLoadingUpdate(false)
                self?.onSearchErrorUpdate(true)
            }
        }
    }
}
 
