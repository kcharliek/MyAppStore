//
//  Unspecified.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/23.
//

import Foundation


@propertyWrapper
struct Unspecified<T> {

    private var value: T?

    init() {
        value = nil
    }

    var wrappedValue: T {
        get {
            guard let value = value else {
                fatalError("\(T.self) is not specified")
            }
            return value
        }
        set {
            value = newValue
        }
    }

}
