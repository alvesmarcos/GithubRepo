//
//  MainViewController.swift
//  GithubRepo
//
//  Created by Marcos Alves on 07/09/21.
//

import UIKit

class MainViewController: UITabBarController {
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    // MARK: - Setup
    
    func prepareUI() {
        let searchNavController = UINavigationController(rootViewController: SearchViewController())
        let aboutNavController = UINavigationController(rootViewController: AboutViewController())
        
        
        aboutNavController.navigationBar.prefersLargeTitles = true
        aboutNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        searchNavController.navigationBar.prefersLargeTitles = true
        searchNavController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        searchNavController.navigationBar.barTintColor = .black
        
        
        searchNavController.title = "Search"
        searchNavController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        aboutNavController.tabBarItem.title = "About"
        aboutNavController.tabBarItem.image = UIImage(systemName: "info.circle")
        
        setViewControllers([searchNavController, aboutNavController], animated: true)
        tabBar.barTintColor = UIColor(named: "DarkGray")
        tabBar.isTranslucent = false
    }
}
