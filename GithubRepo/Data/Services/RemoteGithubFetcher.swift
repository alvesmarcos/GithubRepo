//
//  RemoteGithubFetcher.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Alamofire
import Foundation
import RxAlamofire
import RxSwift

struct GithubFetcherConstants {
    static let kUrl = "https://api.github.com/search/repositories"
}

struct RemoteGithubFetcher: GithubFetcher {
    func fetchRepositories(with query: String) -> Single<(HTTPURLResponse, SearchRepoResponse)> {
        guard let url = URL(string: GithubFetcherConstants.kUrl) else {
            return Single.error(URLError(.badURL))
        }
        return RxAlamofire.requestDecodable(.get, url, parameters: ["q": query]).asSingle()
    }
}
