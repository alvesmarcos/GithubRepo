//
//  AppCoordinator.swift
//  GithubRepo
//
//  Created by Marcos Alves on 18/10/21.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    private let window: UIWindow

    init(windowScene: UIWindowScene) {
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window.windowScene = windowScene
    }

    func start() {
        let tabController = UITabBarController()
        let coordinator = MainCoordinator(rootViewController: tabController)
        coordinator.start()
        self.window.rootViewController = coordinator.rootViewController
        self.window.makeKeyAndVisible()
    }
}
