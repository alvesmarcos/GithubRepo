//
//  SearchViewController.swift
//  GithubRepo
//
//  Created by Marcos Alves on 07/09/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let kRepositoryTableViewCellIdentifier = String(describing: RepositoryTableViewCell.self)
    
    let searchRepositories: SearchRepoResponse = SearchResponseMock
    
    // MARK: - UI Elements
    
    @IBOutlet weak var tableView: UITableView?
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCell()
        prepareUI()
    }
    
    // MARK: - Setup
    
    private func prepareUI() {
        let searchController = UISearchController()
        
        searchController.searchBar.barStyle = .black
        searchController.searchBar.isTranslucent = false
        
        navigationItem.title = "Repositories"
        navigationItem.searchController = searchController
    }
    
    
    private func registerTableViewCell() {
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.register(UINib(nibName: kRepositoryTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: kRepositoryTableViewCellIdentifier)
    }
}

// MARK: - Table View Extension

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchRepositories.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kRepositoryTableViewCellIdentifier) as? RepositoryTableViewCell, indexPath.row < self.searchRepositories.items.count else {
            return RepositoryTableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let repositoryCell = cell as? RepositoryTableViewCell, indexPath.row < self.searchRepositories.items.count else {
            return
        }
        let repository = searchRepositories.items[indexPath.row]
        
        repositoryCell.setupCell(with: repository)
    }
}
