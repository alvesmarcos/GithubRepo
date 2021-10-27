//
//  GithubSearchable.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation
import RxSwift

protocol GithubFetcher {
    func fetchRepositories(with query: String) -> Single<(HTTPURLResponse, SearchRepoResponse)>
}
