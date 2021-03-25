//
//  SearchResultsContainerViewModel.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import Foundation


enum SearchTarget {

    case querySuggestion
    case app

}

class SearchResultsContainerViewModel {
    
    // MARK: - Variables

    var onSearchTargetChanged: ((SearchTarget?) -> Void)?
    let querySuggestionViewModel: SearchQuerySuggestionViewModel
    let searchAppViewModel: SearchAppViewModel

    private var lastSearchText: String?

    // MARK: - Initializer

    init(querySuggestionEngine: QuerySuggestionEngine, appSearchEngine: AppSearchEngine) {
        querySuggestionViewModel = .init(querySuggestionEngine: querySuggestionEngine)
        searchAppViewModel = .init(appSearchEngine: appSearchEngine)
    }

    // MARK: - Methods

    func updateSearchText(_ searchText: String?) {
        guard let searchText = searchText, searchText.isEmpty == false else {
            clear()
            return
        }
        guard searchText != lastSearchText else {
            return
        }
        search(with: searchText, target: .querySuggestion)
    }

    func search(with searchText: String, target: SearchTarget) {
        lastSearchText = searchText
        onSearchTargetChanged?(target)

        switch target {
        case .querySuggestion:
            querySuggestionViewModel.suggestQuery(with: searchText)
        case .app:
            searchAppViewModel.searchApp(with: searchText)
        }
    }

}

// MARK: - Private

private extension SearchResultsContainerViewModel {

    func clear() {
        onSearchTargetChanged?(nil)
        lastSearchText = nil
    }

}
