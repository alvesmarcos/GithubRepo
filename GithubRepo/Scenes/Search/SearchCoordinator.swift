//
//  SearchCoordinator.swift
//  GithubRepo
//
//  Created by Marcos Alves on 18/10/21.
//

import Foundation
import UIKit

class SearchCoordinator: NavigationCoordinator {
    var isCompleted: (() -> Void)?
    
    var rootViewController: UINavigationController

    var childCoordinators = [Coordinator]()

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        let searchViewController = SearchViewController()
        let searchViewModel = SearchViewModel(coordinator: self)
        searchViewController.bindViewModel(to: searchViewModel)
        setupRootViewController()
        self.rootViewController.setViewControllers([searchViewController], animated: true)
    }

    private func setupRootViewController() {
        rootViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        rootViewController.navigationBar.barTintColor = .black
        rootViewController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        rootViewController.title = "Search"
        rootViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    }
}
