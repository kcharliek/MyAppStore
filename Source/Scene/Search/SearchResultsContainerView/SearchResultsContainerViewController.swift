//
//  SearchQuerySuggestionViewController.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/19.
//

import UIKit


protocol SearchResultsContainerViewControllerDelegate: AnyObject {
    
    func searchResultsContainerViewController(_ viewController: SearchResultsContainerViewController, didSelectApp app: App)
    func searchResultsContainerViewController(_ viewController: SearchResultsContainerViewController, didSelectSuggestedQuery query: String)

}


class SearchResultsContainerViewController: UIViewController {

    // MARK: - Variables
    
    weak var delegate: SearchResultsContainerViewControllerDelegate?
    
    private let viewModel: SearchResultsContainerViewModel

    private lazy var querySuggestionView: SearchQuerySuggestionView = {
        let view = SearchQuerySuggestionView(viewModel: viewModel.querySuggestionViewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    private lazy var searchAppView: SearchAppView = {
        let view = SearchAppView(viewModel: viewModel.searchAppViewModel)

        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self

        return view
    }()

    // MARK: - Initializer

    init(viewModel: SearchResultsContainerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        bind(viewModel)
    }
    
    private func bind(_ viewModel: SearchResultsContainerViewModel) {
        viewModel.onSearchTargetChanged = { [weak self] in
            self?.updateUI(forSearchTarget: $0)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("Do Not Use With Interface Builder")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

}

// MARK: - UISearchBarDelegate

extension SearchResultsContainerViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        viewModel.search(with: searchText, target: .app)
    }

}

// MARK: - UISearchResultsUpdating

extension SearchResultsContainerViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        viewModel.updateSearchText(searchController.searchBar.text)
    }

}

// MARK: - SearchQuerySuggestionViewDelegate

extension SearchResultsContainerViewController: SearchQuerySuggestionViewDelegate {

    func searchQuerySuggestionView(_ viewController: SearchQuerySuggestionView, didSelectQuery query: String) {
        delegate?.searchResultsContainerViewController(self, didSelectSuggestedQuery: query)
//        viewModel.search(with: query, target: .app)
    }

}

// MARK: - SearchAppViewDelegate

extension SearchResultsContainerViewController: SearchAppViewDelegate {

    func searchAppView(_ view: SearchAppView, didSelectApp app: App) {
        delegate?.searchResultsContainerViewController(self, didSelectApp: app)
    }

}

// MARK: - Private

private extension SearchResultsContainerViewController {

    private func setupSubviews() {
        [querySuggestionView, searchAppView].forEach { (view) in
            view.isHidden = true
            self.view.addSubview(view)

            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        }
    }

    private func updateUI(forSearchTarget searchTarget: SearchTarget?) {
        switch searchTarget {
        case .querySuggestion:
            querySuggestionView.isHidden = false
            searchAppView.isHidden = true
        case .app:
            querySuggestionView.isHidden = true
            searchAppView.isHidden = false
        case nil:
            querySuggestionView.isHidden = true
            searchAppView.isHidden = true
        }
    }

}
