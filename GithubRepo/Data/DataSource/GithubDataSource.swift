//
//  GithubDataSource.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation
import RxSwift

protocol GithubDataSource {
    func getRepositories(with query: String) -> Single<[Repository]>
}
