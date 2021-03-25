//
//  Query+CoreDataClass.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/21.
//
//

import Foundation
import CoreData

@objc(Query)
public class Query: NSManagedObject {

}

class QueryInsertionContext: NSObject, CoreDataInsertionContext {

    let text: String
    let searchDate: Date?
    let entityType: NSManagedObject.Type = Query.self

    init(text: String, searchDate: Date?) {
        self.text = text
        self.searchDate = searchDate

        super.init()        
    }

}
