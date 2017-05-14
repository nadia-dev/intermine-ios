//
//  MineModel+CoreDataProperties.swift
//  intermine-ios
//
//  Created by Nadia on 5/14/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation
import CoreData


extension MineModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MineModel> {
        return NSFetchRequest<MineModel>(entityName: "MineModel")
    }

    @NSManaged public var url: String?
    @NSManaged public var releaseDate: NSDate?
    @NSManaged public var xmlFile: String?
    @NSManaged public var versioned: Bool

}
