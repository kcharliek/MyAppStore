//
//  CoreDataWrapper.swift
//  MyAppStore
//
//  Created by CHANHEE KIM on 2021/03/20.
//

import Foundation
import CoreData


class CoreDataWrapper {

    static var shared = CoreDataWrapper()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                assertionFailure("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Methods

    func saveContext() throws {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            try context.save()
        }
    }

    func fetch<T>(_ request: NSFetchRequest<T>) throws -> [T] {
        let context = persistentContainer.viewContext

        let results = try context.fetch(request)

        return results
    }

    func delete(_ object: NSManagedObject) throws {
        let context = persistentContainer.viewContext
        context.delete(object)
    }

    func insert(_ insertionContext: CoreDataInsertionContext) throws {
        let context = persistentContainer.viewContext

        let newObject = NSEntityDescription.insertNewObject(forEntityName: insertionContext.entityType.className, into: context)
        newObject.setValuesForKeys(insertionContext.contents)

        try context.save()
    }

    func update(_ object: NSManagedObject) throws {
        try object.managedObjectContext?.save()
    }

}
