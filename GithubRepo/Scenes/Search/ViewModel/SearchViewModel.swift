//
//  SearchViewModel.swift
//  GithubRepo
//
//  Created by Marcos Alves on 09/10/21.
//

import Foundation

class SearchViewModel {
    
    // MARK: - Attributes
    
    var repositoryCellViewModels: Observable<[RepositoryCellViewModel]> = .init([])
    var loading: Observable<Bool> = .init(false)
    var error: Observable<String?> = .init(nil)
    

    // MARK: - Methods
    
    private func onSearchRepositoryCellUpdate(_ repo: [Repository]) {
        self.repositoryCellViewModels.value = repo.map { RepositoryCellViewModel(repository: $0) }
    }
    
    
    func fetchRepositories(searchText: String) {
        self.loading.value = true
        
        GithubFetcher.fetchRepositories(query: searchText) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.onSearchRepositoryCellUpdate(repositories.items)
                self?.error.value = nil
                self?.loading.value = false
                
            case .failure(let error):
                self?.error.value = error.localizedDescription
                self?.loading.value = false
            }
        }
    }
}
