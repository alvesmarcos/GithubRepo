//
//  DataMapper.swift
//  GithubRepo
//
//  Created by Marcos Alves on 15/10/21.
//

import Foundation

protocol DataMapper {
    associatedtype DataModel
    associatedtype DomainModel

    static func map(_ data: DataModel) -> DomainModel
}
