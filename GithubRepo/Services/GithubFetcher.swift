//
//  API.swift
//  GithubRepo
//
//  Created by Marcos Alves on 02/10/21.
//

import Foundation

struct GithubFetcherConstants {
    static let kUrl = "https://api.github.com/search/repositories?q="
}


struct GithubFetcher {
    
    enum GithubFetcherError: Error {
        case invalidURL
        case missingData
    }
    
    static func fetchRepositories(query: String, completion: @escaping(Result<SearchRepoResponse, Error>) -> Void) {
        guard let url = URL(string: "\(GithubFetcherConstants.kUrl)\(query)") else {
            completion(.failure(GithubFetcherError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(GithubFetcherError.missingData))
                return
            }
            
            do {
                let repository = try JSONDecoder().decode(SearchRepoResponse.self, from: data)
                completion(.success(repository))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
 
