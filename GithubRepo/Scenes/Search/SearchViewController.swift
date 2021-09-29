//
//  SearchViewController.swift
//  GithubRepo
//
//  Created by Marcos Alves on 07/09/21.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
    }
    
    // MARK: - Setup
    
    func prepareUI() {
        let searchController = UISearchController()
        
        searchController.searchBar.barStyle = .black
        searchController.searchBar.isTranslucent = false
        
        navigationItem.title = "Repositories"
        navigationItem.searchController = searchController
    }
}
