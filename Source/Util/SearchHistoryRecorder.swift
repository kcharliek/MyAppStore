//
//  SearchHistoryRecorder.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation


protocol SearchHistoryRecorder: AnyObject {

    var onSearchHistoryUpdated: (() -> Void)? { get set }

    func record(_ query: String) throws

}

class SearchHistoryDatabaseRecorder: SearchHistoryRecorder {

    var onSearchHistoryUpdated: (() -> Void)?

    func record(_ query: String) throws {
        let allQuery: [Query] = try CoreDataWrapper.shared.fetch(Query.fetchRequest())

        if let oldQuery = allQuery.first(where: { $0.text == query }) {
            oldQuery.searchDate = .now
            try CoreDataWrapper.shared.update(oldQuery)
        } else {
            try CoreDataWrapper.shared.insert(QueryInsertionContext(text: query, searchDate: .now))
        }

        onSearchHistoryUpdated?()
    }

}
