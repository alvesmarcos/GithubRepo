//
//  SearchViewController.swift
//  GithubRepo
//
//  Created by Marcos Alves on 07/09/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchTimer: Timer?
    
    private let kDebounceTime = 0.5
    private let kMinStringToSearch = 3
    
    private let kRepositoryTableViewCellIdentifier = String(describing: RepositoryTableViewCell.self)
    
    var searchRepositories: SearchRepoResponse = SearchRepoResponse(totalCount: 0, incompleteResults: false, items: [])
    
    // MARK: - UI Elements
    
    let searchController = UISearchController()
    
    @IBOutlet weak var tableView: UITableView?
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCell()
        prepareUI()
    }
    
    // MARK: - Networking
    
    private func getRepositories(searchText: String) {
        GithubFetcher.fetchRepositories(query: searchText) { [weak self] result in
            switch result {
            case .success(let repositories):
                DispatchQueue.main.async {
                    self?.searchRepositories = repositories
                    self?.tableView?.reloadData()
                }
            case .failure(let error):
                print("#[(DEBUG)] Request failed with error \(error)")
            }
        }
    }
    
    
    // MARK: - Setup
    
    private func prepareUI() {
        searchController.searchBar.barStyle = .black
        searchController.searchBar.isTranslucent = false
        searchController.searchResultsUpdater = self
        
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
        
        let repository = searchRepositories.items[indexPath.row]
        cell.setupCell(with: repository)
        
        return cell
    }
}

// MARK: - SearchBar Extension

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchTimer?.invalidate()
        
        guard let text = searchController.searchBar.text else {
            return
        }
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: kDebounceTime, repeats: false, block: { [weak self] timer in
            DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                if text.count > self!.kMinStringToSearch {
                    self?.getRepositories(searchText: text)
                }
            }
        })
    }
}
