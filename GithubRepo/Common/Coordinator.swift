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
    // This closure must be invoked whenever the coordnator ends its flow to notify
    // the parent coordinator to free the current child [MA]
    var isCompleted: (() -> Void)? { get set }

    func start()
}

extension Coordinator {
    func store(coordinator: Coordinator) {
        coordinator.isCompleted = { [weak self, weak coordinator] in
            if let coordinator = coordinator {
                self?.free(coordinator: coordinator)
            }
        }
        childCoordinators.append(coordinator)
    }

    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
