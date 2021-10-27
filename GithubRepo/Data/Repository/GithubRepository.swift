//
//  GithubRepository.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation
import RxRelay

enum FetchState {
    case loading, error, content, empty, inital
}

protocol GithubRepository {
    var repositories: BehaviorRelay<[Repository]> { get }
    var state: BehaviorRelay<FetchState> { get }

    func fetchRepositories(with query: String)
}
