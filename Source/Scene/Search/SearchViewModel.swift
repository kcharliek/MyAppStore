//
//  SearchViewModel.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation


class SearchViewModel {

    // MARK: - Variables

    lazy var searchHistoryViewModel: SearchHistoryViewModel = {
        SearchHistoryViewModel(searchHistoryProvider: searchHistoryProvider)
    }()

    let searchResultsContainerViewModel: SearchResultsContainerViewModel

    private let searchResultsContainerViewFactory: SearchResultsContainerViewFactory
    private let searchHistoryRecorder: SearchHistoryRecorder
    private let searchHistoryProvider: SearchHistoryProvider

    // MARK: - Initializer

    init(searchResultsContainerViewFactory: SearchResultsContainerViewFactory, searchHistoryRecorder: SearchHistoryRecorder, searchHistoryProvider: SearchHistoryProvider) {
        self.searchResultsContainerViewFactory = searchResultsContainerViewFactory
        self.searchHistoryRecorder = searchHistoryRecorder
        self.searchHistoryProvider = searchHistoryProvider
        self.searchResultsContainerViewModel = searchResultsContainerViewFactory.makeSearchResultsContainerViewModel()

        bind()
    }

    private func bind() {
        searchHistoryRecorder.onSearchHistoryUpdated = { [weak self] in
            self?.searchHistoryViewModel.updateSearchHistory()
        }
    }

    // MARK: - Methods

    func makeSearchResultsContainerViewController() -> SearchResultsContainerViewController {
        return searchResultsContainerViewFactory.makeSearchResultsContainerViewController(viewModel: searchResultsContainerViewModel)
    }

    func updateSearchHistory() {
        searchHistoryViewModel.updateSearchHistory()
    }

    func searchApp(with query: String) {
        searchResultsContainerViewModel.search(with: query, target: .app)
    }

}
