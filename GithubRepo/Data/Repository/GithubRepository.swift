//
//  GithubRepository.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

protocol GithubRepositoryDelegate: AnyObject {
    func didChangeLoading(loading: Bool)
    func didChangeRepositories(repositories: [Repository])
    func didChangeError(error: Bool)
}

protocol GithubRepository {
    var delegate: GithubRepositoryDelegate? { get set }
    var repositories: [Repository] { get }
    var loading: Bool { get }
    var error: Bool { get }

    func fetchRepositories(with query: String)
}
