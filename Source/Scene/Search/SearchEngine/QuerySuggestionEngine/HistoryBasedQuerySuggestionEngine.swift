//
//  HistoryBasedQuerySuggestionEngine.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import Foundation


class HistoryBasedQuerySuggestionEngine: QuerySuggestionEngine {

    private static let maximumSuggestionCount: Int = 30

    private let searchHistoryProvider: SearchHistoryProvider
    private let debouncer = Debouncer(delay: 0.3)

    init(searchHistoryProvider: SearchHistoryProvider) {
        self.searchHistoryProvider = searchHistoryProvider
    }

    func suggestQuery(with hint: String, usesDebouncing: Bool, completion: @escaping (Result<[String], Error>) -> Void) {
        let block: () -> Void = { [weak self] in
            self?.searchHistoryProvider.fetchAll { result in
                let suggestions = result.map {
                    $0.filter { $0.localizedCaseInsensitiveContains(hint) }
                        .prefix(Self.maximumSuggestionCount)
                        .map { $0 }
                }
                completion(suggestions)
            }
        }
        if usesDebouncing {
            debouncer.schedule(block: block)
        } else {
            block()
        }
    }

}
