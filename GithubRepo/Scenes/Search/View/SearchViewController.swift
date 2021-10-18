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
    private let kInitialSearchStateText = "Tente buscar por algum repositório"
    private let kEmptySearchStateText = "Nenhum repositorório encontrado"
    private let kErrorSearchStateText = "Desculpe! Ocorreu algum erro"

    // MARK: - Attributes

    private var searchViewModel: SearchViewModel?
    private var searchTimer: Timer?

    // MARK: - UI Elements

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.barStyle = .black
        searchController.searchBar.isTranslucent = false
        searchController.searchResultsUpdater = self
        return searchController
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = UIColor.white
        return activity
    }()

    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var stateView: UIView?
    @IBOutlet private weak var stateImageView: UIImageView?
    @IBOutlet private weak var stateTextView: UILabel?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        registerTableViewCell()
        prepareUI()
    }

    // MARK: - View Model

    func bindViewModel(to viewModel: SearchViewModel) {
        self.searchViewModel = viewModel
        self.searchViewModel?.delegate = self
    }

    // MARK: - Setup

    private func prepareUI() {
        navigationItem.title = "Repositories"
        navigationItem.searchController = searchController
        handleSearchInitialState()
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
    }

    private func registerTableViewCell() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(
            UINib(
                nibName: RepositoryTableViewCell.kTableViewCellIdentifier,
                bundle: nil
            ),
            forCellReuseIdentifier: RepositoryTableViewCell.kTableViewCellIdentifier
        )
    }

    // MARK: - Helper Methods

    private func handleSearchInitialState() {
        self.stateView?.isHidden = false
        self.stateTextView?.text = kInitialSearchStateText
        self.stateImageView?.image = UIImage(named: "Bookmark")
    }

    private func handleSearchEmptyState() {
        self.stateView?.isHidden = false
        self.stateTextView?.text = kEmptySearchStateText
        self.stateImageView?.image = UIImage(named: "BookmarkMad")
    }

    private func handleSearchErrorState() {
        self.stateView?.isHidden = false
        self.stateTextView?.text = kErrorSearchStateText
        self.stateImageView?.image = UIImage(named: "BookmarkError")
    }
}

// MARK: - Notifications from View Model

extension SearchViewController: SearchViewModelDelegate {
    func onChangeSearchError(error: Bool) {
        DispatchQueue.main.async {
            if error {
                self.handleSearchErrorState()
            }
        }
    }

    func onChangeSearchLoadingState(isLoading: Bool) {
        DispatchQueue.main.async {
            if isLoading {
                self.spinner.startAnimating()
            } else {
                self.spinner.stopAnimating()
            }
        }
    }

    func onChangeSearchRepository(repoCellViewModels: [RepositoryCellViewModel]) {
        DispatchQueue.main.async {
            if repoCellViewModels.isEmpty {
                self.handleSearchEmptyState()
            } else {
                self.stateView?.isHidden = true
                self.tableView?.reloadData()
            }
        }
    }
}

// MARK: - Table View Extension

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel?.repositoryCellViewModels.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RepositoryTableViewCell.kTableViewCellIdentifier
        ) as? RepositoryTableViewCell, indexPath.row < self.searchViewModel?.repositoryCellViewModels.count ?? 0 else {
            return RepositoryTableViewCell()
        }
        if let repositoryViewModel = self.searchViewModel?.repositoryCellViewModels[indexPath.row] {
            cell.setupCell(with: repositoryViewModel)
        }
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
        searchTimer = Timer.scheduledTimer(
            withTimeInterval: kDebounceTime,
            repeats: false,
            block: { [weak self] _ in
                DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                    if text.count > self?.kMinStringToSearch ?? 0 {
                        self?.searchViewModel?.fetchRepositories(query: text)
                    }
                }
            }
        )
    }
}
