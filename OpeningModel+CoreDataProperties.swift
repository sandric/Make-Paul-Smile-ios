//
//  OpeningModel+CoreDataProperties.swift
//  
//
//  Created by sandric on 16.02.16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension OpeningModel {

    @NSManaged var name: String?
    @NSManaged var group: String?
    @NSManaged var moves: String?
    @NSManaged var annotations: String?
    @NSManaged var details: String?
    @NSManaged var startingMove: NSNumber?

}
