//
//  RemoteGithubFetcher.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Alamofire
import Foundation

struct GithubFetcherConstants {
    static let kUrl = "https://api.github.com/search/repositories"
}

struct RemoteGithubFetcher: GithubFetcher {
    func fetchRepositories(with query: String, completion: @escaping(Result<SearchRepoResponse, Error>) -> Void) {
        guard let url = URL(string: GithubFetcherConstants.kUrl) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        AF.request(url, method: .get, parameters: ["q": query])
            .responseDecodable(of: SearchRepoResponse.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
