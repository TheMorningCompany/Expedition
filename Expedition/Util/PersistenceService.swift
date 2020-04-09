//
//  PersistenceService.swift
//  Expedition
//
//  Created by Julian Wright on 1/8/20.
//  Copyright © 2020 The Morning Company. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {
    
    // MARK: Core Data stack
    
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "History")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    // MARK: Core Data saving support
    static func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = persistentContainer.viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
            print("SAVED!")
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
