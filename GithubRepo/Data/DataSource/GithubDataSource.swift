//
//  GithubDataSource.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

protocol GithubDataSource {
    func getRepositories(with query: String, completion: @escaping (Result<[Repository], Error>) -> Void)
}
