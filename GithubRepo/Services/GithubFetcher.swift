//
//  API.swift
//  GithubRepo
//
//  Created by Marcos Alves on 02/10/21.
//

import Foundation
import Alamofire

struct GithubFetcherConstants {
    static let kUrl = "https://api.github.com/search/repositories"
    static let kNotFoundStatusCode = 404
    static let kSuccessStatusCodeRange = 200...300
    
    // MARK: - Headers Keys
    
    static let kContentTypeValue = "application/json; charset=utf-8"
}


struct GithubFetcher {
    
    enum GithubFetcherError: Error {
        case invalidURL
        case missingData
    }
    
    static func fetchRepositories(query: String, completion: @escaping(Result<SearchRepoResponse, Error>) -> Void) {
        guard let url = URL(string: GithubFetcherConstants.kUrl) else {
            completion(.failure(GithubFetcherError.invalidURL))
            return
        }
        
        AF.request(url, method: .get, parameters: ["q": query]).responseDecodable(of: SearchRepoResponse.self) { response in
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
                        
        }
    }
}
 
