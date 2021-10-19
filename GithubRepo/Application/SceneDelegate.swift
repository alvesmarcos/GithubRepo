//
//  SceneDelegate.swift
//  GithubRepo
//
//  Created by Marcos Alves on 06/09/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private var coordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        self.coordinator = AppCoordinator(windowScene: windowScene)
        self.coordinator?.start()
    }
}
