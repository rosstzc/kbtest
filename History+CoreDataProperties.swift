//
//  History+CoreDataProperties.swift
//  keenbrace
//
//  Created by michaeltam on 15/11/18.
//  Copyright © 2015年 mike公司. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension History {

    @NSManaged var cadence: String?
    @NSManaged var date: NSDate?
    @NSManaged var distance: String?
    @NSManaged var score: String?
    @NSManaged var speed: String?
    @NSManaged var time: String?

}
