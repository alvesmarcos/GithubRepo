//
//  MainCoordinator.swift
//  GithubRepo
//
//  Created by Marcos Alves on 16/10/21.
//

import Foundation
import UIKit

class MainCoordinator: TabCoordinator {
    // MARK: - Properties

    var childCoordinators = [Coordinator]()
    var rootViewController: UITabBarController

    // MARK: - Constructors

    init(rootViewController: UITabBarController) {
        self.rootViewController = rootViewController
    }

    // MARK: - Methods

    func start() {
        let aboutCoordinator = AboutCoordinator(rootViewController: UINavigationController())
        let searchCoordinator = SearchCoordinator(rootViewController: UINavigationController())

        aboutCoordinator.start()
        searchCoordinator.start()

        rootViewController.setViewControllers(
            [searchCoordinator.rootViewController, aboutCoordinator.rootViewController],
            animated: true
        )
        rootViewController.tabBar.barTintColor = UIColor(named: "DarkGray")
        rootViewController.tabBar.isTranslucent = false
    }
}
