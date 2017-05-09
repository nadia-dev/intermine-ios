//
//  Mine+CoreDataClass.swift
//  intermine-ios
//
//  Created by Nadia on 5/7/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation
import CoreData

@objc(Mine)
public class Mine: NSManagedObject {
    
    class func createMineFromJson(json: Dictionary<String, String>, context: NSManagedObjectContext) {
        guard let mineEntiry = NSEntityDescription.entity(forEntityName: "Mine", in: context) else {
            return
        }
        let mine = Mine(entity: mineEntiry, insertInto: context)
        mine.name = json["name"]
        mine.url = json["url"]
        mine.theme = json["theme"]
        mine.lastUpdated = NSDate()
    }
    
    class func getMineByName(name: String, context: NSManagedObjectContext) -> Mine? {
        let request = NSFetchRequest<Mine>(entityName: "Mine")
        request.predicate =  NSPredicate(format: "name == %@", name)
        if let mines = try? context.fetch(request) {
            if mines.count > 0 {
                return mines.first
            }
        }
        return nil
    }

}
