//
//  SearchViewFactory.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation


protocol SearchViewFactory: AnyObject {
    
    func makeSearchViewModel() -> SearchViewModel
    func makeSearchViewController() -> SearchViewController

}

class DefaultSearchViewFactory: SearchViewFactory {

    private let searchHistoryRecorder: SearchHistoryRecorder = SearchHistoryDatabaseRecorder()
    private let searchHistoryProvider: SearchHistoryProvider = SearchHistoryDatabaseProvider()

    func makeSearchViewModel() -> SearchViewModel {
        return SearchViewModel(
            searchResultsContainerViewFactory: makeSearchResultsContainerViewFactory(),
            searchHistoryRecorder: searchHistoryRecorder,
            searchHistoryProvider: searchHistoryProvider
        )
    }

    func makeSearchViewController() -> SearchViewController {
        return SearchViewController(viewModel: makeSearchViewModel())
    }

    private func makeSearchResultsContainerViewFactory() -> SearchResultsContainerViewFactory {
        return DefaultSearchResultsContainerViewFactory(
            searchHistoryRecorder: searchHistoryRecorder,
            searchHistoryProvider: searchHistoryProvider
        )
    }

}
