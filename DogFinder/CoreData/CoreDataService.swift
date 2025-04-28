//
//  CoreDataService.swift
//  DogFinder
//
//  Created by Anastasia N.  on 21.04.2025.
//

import Foundation
import CoreData


final class CoreDataService {
    
    static let shared = CoreDataService()
    let container: NSPersistentContainer
    private var containerName:  String = "DogContainer"
    let viewContext: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data! \(error.localizedDescription)")
            }
        }
        if let storeURL = container.persistentStoreDescriptions.first?.url {
            print("Core Data store URL: \(storeURL)")
        }
        viewContext = container.viewContext
    }
}
    
