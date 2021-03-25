//
//  APIBasedAppSearchEngine.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation


class APIBasedAppSearchEngine: AppSearchEngine {

    private let searchHistoryRecorder: SearchHistoryRecorder

    init(searchHistoryRecorder: SearchHistoryRecorder) {
        self.searchHistoryRecorder = searchHistoryRecorder
    }

    func searchApp(with query: String, completion: @escaping (Result<[App], Error>) -> Void) {
        try? searchHistoryRecorder.record(query)

        API.Search(query: query).execute { (result) in
            let appResult = result
                .map { $0.results }
                .map { $0.map(AppConverter.convert) }
            completion(appResult)
        }
    }

}
