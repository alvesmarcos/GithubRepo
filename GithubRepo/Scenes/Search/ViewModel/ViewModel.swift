//
//  ViewModel.swift
//  GithubRepo
//
//  Created by Marcos Alves on 13/10/21.
//

import Foundation

protocol SearchViewModelDelegate {
    func onChangeSearchLoadingState(isLoading: Bool)
    func onChangeSearchRepository(repoCellViewModels: [RepositoryCellViewModel])
    func onChangeSearchError(error: Bool)
}

protocol ViewModelSearching {
    func fetchRepositories(query: String)
    var delegate: SearchViewModelDelegate? { get set }
}
