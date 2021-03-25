//
//  SearchViewController.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/19.
//

import UIKit


class SearchViewController: UIViewController {

    // MARK: - Variables

    weak var coordinator: SearchCoordinator?

    private let viewModel: SearchViewModel

    private lazy var historyView: SearchHistoryView = {
        let view = SearchHistoryView(viewModel: viewModel.searchHistoryViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    private lazy var searchController: UISearchController = {
        let searchResultsContainerViewController = viewModel.makeSearchResultsContainerViewController()
        searchResultsContainerViewController.delegate = self

        let searchController = UISearchController(searchResultsController: searchResultsContainerViewController)

        searchController.searchBar.delegate = searchResultsContainerViewController
        searchController.searchResultsUpdater = searchResultsContainerViewController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.showsCancelButton = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Text.search_bar_placeholder.value
        if #available(iOS 13.0, *) {
            searchController.automaticallyShowsCancelButton = true
        }

        return searchController
    }()

    // MARK: - Initializer

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Do Not Use With Interface Builder")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupNavigationController()
        viewModel.updateSearchHistory()
    }

}

// MARK: - SearchHistoryViewDelegate

extension SearchViewController: SearchHistoryViewDelegate {

    func searchHistoryView(_ view: SearchHistoryView, didSelectRecentQuery query: String) {
        search(with: query)
    }

}

// MARK: - SearchResultsContainerViewControllerDelegate

extension SearchViewController: SearchResultsContainerViewControllerDelegate {

    func searchResultsContainerViewController(_ viewController: SearchResultsContainerViewController, didSelectApp app: App) {
        coordinator?.showAppDetail(with: app)
    }

    func searchResultsContainerViewController(_ viewController: SearchResultsContainerViewController, didSelectSuggestedQuery query: String) {
        search(with: query)
    }

}

// MARK: - Private

private extension SearchViewController {

    func setupSubViews() {
        navigationItem.searchController = searchController
        view.backgroundColor = Color.defaultViewBackground.value
        definesPresentationContext = true

        setupHistoryView()
    }

    func setupNavigationController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Text.search.value
    }

    func setupHistoryView() {
        self.view.addSubview(historyView)
        NSLayoutConstraint.activate([
            historyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            historyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            historyView.leftAnchor.constraint(equalTo: view.leftAnchor),
            historyView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    func search(with query: String) {
        searchController.searchBar.becomeFirstResponder()
        searchController.searchBar.text = query
        viewModel.searchApp(with: query)
        searchController.searchBar.resignFirstResponder()
    }

}
