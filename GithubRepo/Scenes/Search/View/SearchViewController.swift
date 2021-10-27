//
//  SearchViewController.swift
//  GithubRepo
//
//  Created by Marcos Alves on 07/09/21.
//

import RxCocoa
import RxRelay
import RxSwift
import UIKit

class SearchViewController: UIViewController {
    // MARK: - Constants

    private let kDebounceTime = 0.5
    private let kMinStringToSearch = 3
    private let kInitialSearchStateText = "Tente buscar por algum repositório"
    private let kEmptySearchStateText = "Nenhum repositorório encontrado"
    private let kErrorSearchStateText = "Desculpe! Ocorreu algum erro"

    // MARK: - Attributes

    private let disposeBag = DisposeBag()
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
        subscribeSearchState()
        subscribeTableData()
        prepareUI()
    }

    // MARK: - View Model

    func bindViewModel(to viewModel: SearchViewModel) {
        self.searchViewModel = viewModel
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
        self.spinner.stopAnimating()
        self.stateView?.isHidden = false
        self.stateTextView?.text = kInitialSearchStateText
        self.stateImageView?.image = UIImage(named: "Bookmark")
    }

    private func handleSearchEmptyState() {
        self.spinner.stopAnimating()
        self.stateView?.isHidden = false
        self.stateTextView?.text = kEmptySearchStateText
        self.stateImageView?.image = UIImage(named: "BookmarkMad")
    }

    private func handleSearchErrorState() {
        self.spinner.stopAnimating()
        self.stateView?.isHidden = false
        self.stateTextView?.text = kErrorSearchStateText
        self.stateImageView?.image = UIImage(named: "BookmarkError")
    }

    private func handleSearchLoadingState() {
        self.spinner.startAnimating()
        self.stateView?.isHidden = true
    }

    private func handleSearchContentState() {
        self.spinner.stopAnimating()
        self.stateView?.isHidden = true
    }
}

// MARK: - Handle Notifications from View Model

extension SearchViewController {
    func subscribeSearchState() {
        searchViewModel?.state
            .asDriver()
            .drive { [weak self] value in
                switch value {
                case .inital:
                    self?.handleSearchInitialState()
                case .loading:
                    self?.handleSearchLoadingState()
                case .error:
                    self?.handleSearchErrorState()
                case .empty:
                    self?.handleSearchEmptyState()
                case .content:
                    self?.handleSearchContentState()
                }
            }
        .disposed(by: disposeBag)
    }

    func subscribeTableData() {
        guard let tableView = self.tableView else {
            return
        }
        searchViewModel?.repositoryCellViewModels.bind(
            to: tableView.rx.items(
                cellIdentifier: RepositoryTableViewCell.kTableViewCellIdentifier,
                cellType: RepositoryTableViewCell.self
            )) { _, item, cell in
            cell.setupCell(with: item)
        }
        .disposed(by: disposeBag)
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
