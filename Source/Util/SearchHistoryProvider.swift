//
//  SearchHistoryProvider.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation


protocol SearchHistoryProvider: AnyObject {

    func fetchAll(_ completion: @escaping (Result<[String], Error>) -> Void)

}

class SearchHistoryDatabaseProvider: SearchHistoryProvider {

    func fetchAll(_ completion: @escaping (Result<[String], Error>) -> Void) {
        do  {
            let result = try CoreDataWrapper.shared.fetch(Query.fetchRequest())
                .sorted(by: { $0.searchDate.isEarlier(than: $1.searchDate) })
                .map { $0.text }
            completion(.success(result))
        } catch(let error) {
            completion(.failure(error))
        }
    }

}

private extension Optional where Wrapped == Date {

    func isEarlier(than target: Date?) -> Bool {
        if let unwrappedSelf = self, let unwrappedTarget = target {
            return unwrappedSelf > unwrappedTarget
        } else if self != nil {
            return true
        } else if target != nil {
            return false
        } else {
            return false
        }
    }

}
