//
//  MockCoreDataStack.swift
//  EditProfileTests
//
//  Created by NikoS on 23.07.2024.
//

import CoreData
@testable import EditProfile

class MockCoreDataStack: CoreDataStack {

    override init() {
        super.init()
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: AppConstants.profileCoreDataModelName)
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize in-memory Core Data \(error)")
            }
        }
        
        self.persistentContainer = container
    }
}
