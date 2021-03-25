//
//  Query+CoreDataProperties.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//
//

import Foundation
import CoreData


extension Query {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Query> {
        return NSFetchRequest<Query>(entityName: "Query")
    }

    @NSManaged public var searchDate: Date?
    @NSManaged public var text: String

    var isSearched: Bool {
        return searchDate != nil
    }

}
