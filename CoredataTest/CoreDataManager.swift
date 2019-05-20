//
//  CoreDataManager.swift
//  CoredataTest
//
//  Created by Yuni on 2019/5/20.
//  Copyright © 2019 Yuni. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    static let shared = CoreDataManager()
    fileprivate var context: NSManagedObjectContext?
    
    private override init() {
        super.init()
        
        if let app: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
            context = app.persistentContainer.viewContext
        }
    }
    
    func saveEntities(entityName: String, metaInfo: [String: AnyObject]) {
        if context == nil {
            return
        }
        
        if let entity = NSEntityDescription.entity(forEntityName: entityName, in: context!) {
            let newUser = NSManagedObject(entity: entity, insertInto: context!)
            for (key, value) in metaInfo {
                newUser.setValue(value, forKey: key)
            }
            saveContext()
        }
    }
    
    fileprivate func saveContext() {
        if context == nil {
            return
        }
        
        do {
            try context!.save()
            print("CoreDataManager === saving succeed.")
        } catch {
            print("CoreDataManager === saving failed.")
        }
    }
    
    func fetchEntities(entityName: String, predicate: String?) -> [NSManagedObject] {
        if context == nil {
            return []
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if predicate != nil && predicate != "" {
            request.predicate = NSPredicate(format: predicate!)
        }
        request.returnsObjectsAsFaults = false
        do {
            return try context!.fetch(request) as! [NSManagedObject]
        } catch {
            print("CoreDataManager === fetching failed.")
        }
        
        return []
    }
    
    func deleteEntity(entityName: String, predicate: String?) {
        let results = fetchEntities(entityName: entityName, predicate: predicate)
        for result in results {
            context!.delete(result)
        }
        print("CoreDataManager === deleting.")
        saveContext()
    }
    
    func updateEntity(entityName: String, predicate: String?, metaInfo: [String: AnyObject]) {
        let results = fetchEntities(entityName: entityName, predicate: predicate)
        for result in results {
            for (key, value) in metaInfo {
                result.setValue(value, forKey: key)
            }
            print("CoreDataManager === updating.")
            saveContext()
        }
    }
}
