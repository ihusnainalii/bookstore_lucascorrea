//
//  CoreDataManager.swift
//  BookStore_LucasCorrea
//
//  Created by Lucas Correa on 08/08/2020.
//  Copyright © 2020 SiriusCode. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataManager {
    
    static let shared = CoreDataManager(modelName: "BookStore")
    
    // MARK: - Properties
    private var modelName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
    
    // MARK: - Convenience Init
    public convenience init(modelName model: String) {
        self.init()
        modelName = model
    }
}

// MARK: - Add
extension CoreDataManager {
    
    public func add<M: NSManagedObject>(_ type: M.Type) -> M? {
        var modelObject: M?
        
        if let entity = NSEntityDescription.entity(forEntityName: M.description(), in: context) {
            modelObject = M(entity: entity, insertInto: context)
        }
        return modelObject
    }
}


// MARK: - Fetch
extension CoreDataManager {
    
    public typealias FetchCompletion<M> = ((_ fetched: [M]) -> ())
    
    public func fetch<M: NSManagedObject>(_ type: M.Type,
                                          predicate: NSPredicate? = nil,
                                          sort: NSSortDescriptor? = nil,
                                          _ completion: FetchCompletion<M>? = nil) -> [M]? {
        var fetched: [M]?
        let entityName = String(describing: type)
        let request = NSFetchRequest<M>(entityName: entityName)
        
        request.predicate = predicate
        request.sortDescriptors = [sort] as? [NSSortDescriptor]
        
        if let completion = completion {
            self.context.perform {
                let _ = self.fetchObjects(request, completion)
            }
        } else {
            fetched = fetchObjects(request)
        }
        return fetched
    }
    
    private func fetchObjects<M: NSManagedObject>(_ request: NSFetchRequest<M>,
                                                  _ completion: FetchCompletion<M>? = nil) -> [M] {
        var fetched: [M] = [M]()
        
        do {
            fetched = try context.fetch(request)
            completion?(fetched)
        } catch {
            print("Error executing fetch: \(error)")
            completion?(fetched)
        }
        return fetched
    }
}

// MARK: - Save
extension CoreDataManager {
    
    @discardableResult
    public func save() -> Bool {
        do {
            try self.context.save()
            return true
        } catch {
            return false
        }
    }
}

// MARK: - Delete
extension CoreDataManager {
    
    public func delete(by objectID: NSManagedObjectID) {
        
        let managedObject = context.object(with: objectID)
        
        self.context.delete(managedObject)
    }
    
    public func delete<M: NSManagedObject>(_ type: M.Type, predicate: NSPredicate? = nil) {
        
        if let objects = fetch(type, predicate: predicate) {
            for modelObject in objects {
                delete(by: modelObject.objectID)
            }
        }
        
        if context.deletedObjects.count > 0 {
            save()
        }
    }
}

