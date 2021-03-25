//
//  SwiftExtensions.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import Foundation


extension NSObject {

    var className: String {
        return String(describing: type(of: self))
    }

    class var className: String {
        return String(describing: self)
    }

}


extension Collection {

    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

}

extension Double {

    var humanReadableText: String {
        switch self {
        case ..<1_000:
            return String(format: "%.0f", locale: Locale.current, self)
        case 1_000 ..< 999_999:
            return String(format: "%.1fK", locale: Locale.current, self / 1_000).replacingOccurrences(of: ".0", with: "")
        default:
            return String(format: "%.1fM", locale: Locale.current, self / 1_000_000).replacingOccurrences(of: ".0", with: "")
        }
    }

}

extension Optional where Wrapped == String {

    var isEmpty: Bool {
        orEmpty.isEmpty
    }

    var isNotEmpty: Bool {
        isEmpty == false
    }

    var orEmpty: String {
        self ?? ""
    }

}

extension Optional where Wrapped: Numeric {

    var orZero: Wrapped {
        self ?? 0
    }

}

extension Optional where Wrapped: Collection {

    var isEmpty: Bool {
        return self?.isEmpty ?? true
    }

    var isNotEmpty: Bool {
        isEmpty == false
    }

    var orEmpty: [Wrapped.Element] {
        self?.compactMap({ $0 }) ?? []
    }

    var count: Int {
        self?.count ?? 0
    }

}
