//
//  SearchViewController.swift
//  GithubRepo
//
//  Created by Marcos Alves on 07/09/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Constants
    
    private let kDebounceTime = 0.5
    private let kMinStringToSearch = 3
    private let kRepositoryTableViewCellIdentifier = String(describing: RepositoryTableViewCell.self)
    private let kInitialSearchStateText = "Tente buscar por algum repositório"
    private let kEmptySearchStateText = "Nenhum repositorório encontrado"
    private let kErrorSearchStateText = "Desculpe! Ocorreu algum erro"
    
    // MARK: - Attributes
    
    private let searchViewModel = SearchViewModel()
    var searchTimer: Timer?

    // MARK: - UI Elements
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.barStyle = .black
        searchController.searchBar.isTranslucent = false
        return searchController
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = UIColor.white
        return activity
    }()
    

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var stateView: UIView?
    @IBOutlet weak var stateImageView: UIImageView?
    @IBOutlet weak var stateTextView: UILabel?
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCell()
        bindViewModel()
        prepareUI()
    }
    
    // MARK: - Setup
    
    private func bindViewModel() {
        self.searchViewModel.repositoryCellViewModels.addAndNotify(observer: self) { [weak self] repoCellViewModel in
            self?.onViewModelRepoCellViewModelUpdate(repoCellViewModel)
        }
        self.searchViewModel.loading.addObserver(self) { [weak self] isLoading in
            self?.onViewModelLoadingUpdate(isLoading)
        }
    }
    
    private func prepareUI() {
        searchController.searchResultsUpdater = self
        navigationItem.title = "Repositories"
        navigationItem.searchController = searchController
        
        onSearchInitialState()
        
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
    }
    
    
    private func registerTableViewCell() {
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.register(UINib(nibName: kRepositoryTableViewCellIdentifier, bundle: nil), forCellReuseIdentifier: kRepositoryTableViewCellIdentifier)
    }
    
    
    private func onSearchInitialState() {
        self.stateView?.isHidden = false
        self.stateTextView?.text = kInitialSearchStateText
        self.stateImageView?.image = #imageLiteral(resourceName: "Bookmark")
    }
    
    private func onSearchEmptyState() {
        self.stateView?.isHidden = false
        self.stateTextView?.text = kEmptySearchStateText
        self.stateImageView?.image = #imageLiteral(resourceName: "BookmarkMad")
    }
    
    private func onSearchErrorState() {
        self.stateView?.isHidden = false
        self.stateTextView?.text = kErrorSearchStateText
        self.stateImageView?.image = #imageLiteral(resourceName: "BookmarkError")
    }
    
    // MARK: - ViewModels Updates
    
    private func onViewModelRepoCellViewModelUpdate(_ repoCellViewModels: [RepositoryCellViewModel]) {
        if repoCellViewModels.isEmpty {
            onSearchEmptyState()
        } else {
            self.stateView?.isHidden = true
            self.tableView?.reloadData()
        }
    }
    
    private func onViewModelLoadingUpdate(_ isLoading: Bool) {
        if isLoading {
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
        }
    }
}

// MARK: - Table View Extension

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.repositoryCellViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kRepositoryTableViewCellIdentifier) as? RepositoryTableViewCell, indexPath.row < self.searchViewModel.repositoryCellViewModels.value.count else {
            return RepositoryTableViewCell()
        }
        
        let repositoryViewModel = self.searchViewModel.repositoryCellViewModels.value[indexPath.row]
        cell.setupCell(with: repositoryViewModel)
        
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
                    self?.searchViewModel.fetchRepositories(searchText: text)
                }
            }
        })
    }
}
