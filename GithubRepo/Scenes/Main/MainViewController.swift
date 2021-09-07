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
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let aboutViewController = UINavigationController(rootViewController: AboutViewController())
        
        aboutViewController.navigationBar.prefersLargeTitles = true
        aboutViewController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        searchViewController.title = "Search"
        searchViewController.tabBarItem.image = UIImage(systemName: "search")
        
        aboutViewController.tabBarItem.title = "About"
        
        setViewControllers([searchViewController, aboutViewController], animated: true)
        tabBar.barTintColor = UIColor(named: "DarkGray")
        tabBar.isTranslucent = false
    }
}
