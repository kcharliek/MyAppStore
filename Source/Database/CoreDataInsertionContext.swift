//
//  CoreDataInsertionContext.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//

import Foundation
import CoreData


protocol CoreDataInsertionContext where Self: NSObject {
    
    var entityType: NSManagedObject.Type { get }
    var contents: [String: Any] { get }

}

extension CoreDataInsertionContext {

    var contents: [String: Any] {
        var ret = properties()
        ret["entityType"] = nil
        return ret
    }

}

private extension NSObject {

    func properties() -> [String: Any] {
        let mirror = Mirror(reflecting: self)

        var ret = [String: Any]()

        mirror.children.enumerated().forEach { (_, attribute) in
            if let propertyName = attribute.label {
                ret[propertyName] = attribute.value
            }
        }

        return ret
    }

}
