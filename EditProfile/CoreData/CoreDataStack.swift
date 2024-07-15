//
//  CoreDataStack.swift
//  EditProfile
//
//  Created by NikoS on 13.07.2024.
//

import Foundation
import CoreData

class CoreDataStack {
    
    let persistentContainer: NSPersistentContainer
    static let shared: CoreDataStack = CoreDataStack()
    
    private init() {
        
        ValueTransformer.setValueTransformer(
            UIImageTransformer(),
            forName: NSValueTransformerName("UIImageTransformer")
        )
        
        persistentContainer = NSPersistentContainer(name: AppConstants.profileCoreDataModelName)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
    var mainContext: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    
}
