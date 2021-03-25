//
//  ResultExtensions.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation


extension Result {

    @discardableResult
    func onSuccess(_ handler: (Success) -> Void) -> Result {
        switch self {
        case .success(let value):
            handler(value)
        case .failure(_):
            break
        }
        return self
    }

    @discardableResult
    func onFailure(_ handler: (Failure) -> Void) -> Result {
        switch self {
        case .success(_):
            break
        case .failure(let error):
            handler(error)
        }
        return self
    }
    
}
