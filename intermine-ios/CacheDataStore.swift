//
//  CacheDataStore.swift
//  intermine-ios
//
//  Created by Nadia on 5/7/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation
import CoreData

class CacheDataStore {
    
    private let modelName = Model.modelName
    private let minesUpdateInterval: Double = 432000 //5 days, TODO: -change this value to less often
    
    // MARK: Shared Instance
    
    static let sharedCacheDataStore : CacheDataStore = {
        let instance = CacheDataStore()
        return instance
    }()
    
    // MARK: Public methods
    
    func updateRegistryIfNeeded() {
        if registryNeedsUpdate() {
            IntermineAPIClient.fetchRegistry { (jsonRes) in
                guard let jsonRes = jsonRes else {
                    return
                }
                // update registry in Core Data
                eraseRegistry()
                if let registryDict = jsonRes as? [String: AnyObject] {
                    if let mines = registryDict["mines"] as? Array<[String: String]> {
                        for mine in mines {
                            Mine.createMineFromJson(json: mine, context: self.managedContext)
                        }
                        save()
                    }
                }
            }
        }
    }
    
    func save() {
        saveContext()
    }
    
    // MARK: Private methods
    
    private func fetchCachedRegistry() -> Array<Mine>? {
        do {
            if let registry = try self.managedContext.fetch(Mine.fetchRequest()) as? Array<Mine> {
                print ("fetched")
                print (registry.count)
                return registry
            } else {
                return []
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return nil
        }
    }
    
    private func registryNeedsUpdate() -> Bool {
        if let registry = fetchCachedRegistry() {
            if let mine: Mine = registry.first, let lastUpdated = mine.lastUpdated {
                return NSDate.hasIntervalPassed(lastUpdated: lastUpdated, timeInterval: minesUpdateInterval)
            }
            return true
        }
        // TODO: handle this better!
        // if there was an error fetching
        return false
    }
    
    private func eraseRegistry() {
        if let registry = fetchCachedRegistry() {
            for mine in registry {
                self.managedContext.delete(mine)
            }
        }
    }
    
    // MARK: Core Data stack
    
    private lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private func saveContext () {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    

    
}
