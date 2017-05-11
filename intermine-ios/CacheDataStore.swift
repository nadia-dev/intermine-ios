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
    
    private let modelName = General.modelName
    
    // TODO: compare versions instead using:
//    GET /version/release which tells you the version of the data *inside* the intermine
//    GET /version/intermine, which gives you the version of the intermine software that you're communicating with.
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
    
    func getMouseMine() -> Mine? {
        // FIXME: Debug code, to remove
        return Mine.getMineByName(name: "MouseMine", context: self.managedContext)
    }
    
    func registrySize() -> Int {
        if let registry = self.fetchCachedRegistry() {
            return registry.count
        } else {
            return 0
        }
    }
    
    func allRegistry() -> Array<Mine>? {
        return self.fetchCachedRegistry()?.sorted(by: { (mine0, mine1) -> Bool in
            guard let name0 = mine0.name, let name1 = mine1.name else {
                return false
            }
            return name0 < name1
        })
    }
    
    func findMineByUrl(url: String) -> Mine? {
        return Mine.getMineByUrl(url: url, context: self.managedContext)
    }
    
    
    // MARK: Private methods

    
    private func fetchCachedRegistry() -> Array<Mine>? {
        do {
            if let registry = try self.managedContext.fetch(Mine.fetchRequest()) as? Array<Mine> {
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
