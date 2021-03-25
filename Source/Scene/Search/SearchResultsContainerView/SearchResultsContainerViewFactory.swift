//
//  SearchResultsContainerViewFactory.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import Foundation


protocol SearchResultsContainerViewFactory {

    func makeSearchResultsContainerViewModel() -> SearchResultsContainerViewModel
    func makeSearchResultsContainerViewController(viewModel: SearchResultsContainerViewModel) -> SearchResultsContainerViewController

}

class DefaultSearchResultsContainerViewFactory: SearchResultsContainerViewFactory {

    let searchHistoryRecorder: SearchHistoryRecorder
    let searchHistoryProvider: SearchHistoryProvider

    init(searchHistoryRecorder: SearchHistoryRecorder, searchHistoryProvider: SearchHistoryProvider) {
        self.searchHistoryRecorder = searchHistoryRecorder
        self.searchHistoryProvider = searchHistoryProvider
    }

    func makeSearchResultsContainerViewModel() -> SearchResultsContainerViewModel {
        return SearchResultsContainerViewModel(
            querySuggestionEngine: makeQuerySuggestionEngine(),
            appSearchEngine: makeAppSearchEngine()
        )
    }

    func makeSearchResultsContainerViewController(viewModel: SearchResultsContainerViewModel) -> SearchResultsContainerViewController {
        return SearchResultsContainerViewController(viewModel: viewModel)
    }

    private func makeQuerySuggestionEngine() -> QuerySuggestionEngine {
        return HistoryBasedQuerySuggestionEngine(searchHistoryProvider: searchHistoryProvider)
    }

    private func makeAppSearchEngine() -> AppSearchEngine {
        return APIBasedAppSearchEngine(searchHistoryRecorder: searchHistoryRecorder)
    }

}
