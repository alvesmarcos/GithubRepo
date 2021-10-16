//
//  LocalGithubFetcher.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

struct LocalGithubFetcher: GithubFetcher {
    func fetchRepositories(with query: String, completion: @escaping (Result<SearchRepoResponse, Error>) -> Void) {
        let searchResponseMock = SearchRepoResponse(
            totalCount: 218807, incompleteResults: false, items: [
                RepositoryResponse(
                    id: 44838949,
                    name: "swift",
                    description: "The Swift Programming Language",
                    language: "C++", forks: 9202, stars: 57387,
                    owner: OwnerResponse(id: 10639145,
                                 login: "apple",
                                 avatarUrl: "https://avatars.githubusercontent.com/u/10639145?v=4"))
                ,
                RepositoryResponse(
                    id: 94066125,
                    name: "Swift",
                    description: "🥇Swift基础知识大全,🚀Swift学习从简单到复杂,不断地完善与更新, 欢迎Star❤️,欢迎Fork, iOS开发者交流:①群:446310206 ②群:426087546",
                    language: "C",
                    forks: 417,
                    stars: 1464,
                    owner: OwnerResponse(id: 27724501,
                                 login: "iOS-Swift-Developers",
                                 avatarUrl: "https://avatars.githubusercontent.com/u/27724501?v=4"))
            ]
        )
        completion(.success(searchResponseMock))
    }
}
