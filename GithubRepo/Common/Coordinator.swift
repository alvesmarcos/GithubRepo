//
//  Coordinator.swift
//  GithubRepo
//
//  Created by Marcos Alves on 16/10/21.
//

import Foundation
import UIKit

protocol TabCoordinator: Coordinator {
    var rootViewController: UITabBarController { get }
}

protocol NavigationCoordinator: Coordinator {
    var rootViewController: UINavigationController { get }
}

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }

    func start()
}
