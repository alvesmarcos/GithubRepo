//
//  AboutCoordinator.swift
//  GithubRepo
//
//  Created by Marcos Alves on 18/10/21.
//

import Foundation
import UIKit

class AboutCoordinator: NavigationCoordinator {
    var rootViewController: UINavigationController

    var childCoordinators = [Coordinator]()

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        let aboutViewController = AboutViewController()
        setup()
        self.rootViewController.setViewControllers([aboutViewController], animated: true)
    }

    private func setup() {
        rootViewController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        rootViewController.tabBarItem.title = "About"
        rootViewController.tabBarItem.image = UIImage(systemName: "info.circle")
    }
}
