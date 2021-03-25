//
//  SearchHistoryViewModel.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation


class SearchHistoryViewModel {
    
    var onSearchHistoryUpdated: (() -> Void)?
    private(set) var recentQueries: [String] = []

    private let searchHistoryProvider: SearchHistoryProvider

    init(searchHistoryProvider: SearchHistoryProvider) {
        self.searchHistoryProvider = searchHistoryProvider
    }

    func updateSearchHistory() {
        searchHistoryProvider.fetchAll { [weak self] (result) in
            result.onSuccess {
                self?.recentQueries = $0
                self?.onSearchHistoryUpdated?()
            }
        }
    }

}
