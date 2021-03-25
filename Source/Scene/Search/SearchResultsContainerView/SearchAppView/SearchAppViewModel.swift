//
//  SearchAppViewModel.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import Foundation


class SearchAppViewModel {

    // MARK: - Variables

    var onWillStartAppSearching: (() -> Void)?
    var onAppSearched: ((Result<[App], Error>) -> Void)?

    var apps: [App] = []
    var query: String?

    private let appSearchEngine: AppSearchEngine

    // MARK: - Initializer

    init(appSearchEngine: AppSearchEngine) {
        self.appSearchEngine = appSearchEngine
    }

    // MARK: - Methods

    func searchApp(with query: String) {
        onWillStartAppSearching?()
        appSearchEngine.searchApp(with: query, completion: { [weak self] (result) in
            result.onSuccess {
                self?.apps = $0
            }.onFailure { _ in
                self?.apps = []
            }
            self?.query = query
            self?.onAppSearched?(result)
        })
    }

    func appCellModel(at indexPath: IndexPath) -> AppTableViewCellModel? {
        guard let app = apps[safe: indexPath.section] else {
            return nil
        }
        return .init(app: app)
    }

    func screenshotCellModel(at indexPath: IndexPath) -> SearchAppScreenShotTableViewCellModel? {
        guard let app = apps[safe: indexPath.section] else {
            return nil
        }
        return .init(app: app)
    }

}
