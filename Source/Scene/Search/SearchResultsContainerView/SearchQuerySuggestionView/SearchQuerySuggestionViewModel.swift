//
//  SearchQuerySuggestionViewModel.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import Foundation


class SearchQuerySuggestionViewModel {

    var onQuerySuggested: ((Result<[String], Error>) -> Void)?
    var suggestions: [String] = []

    private let querySuggestionEngine: QuerySuggestionEngine

    init(querySuggestionEngine: QuerySuggestionEngine) {
        self.querySuggestionEngine = querySuggestionEngine
    }
    
    func suggestQuery(with hint: String) {
        querySuggestionEngine.suggestQuery(with: hint, usesDebouncing: true, completion: { [weak self] (results) in
            results.onSuccess {
                self?.suggestions = $0
            }.onFailure { _ in
                self?.suggestions = []
            }
            self?.onQuerySuggested?(results)
        })
    }

}
