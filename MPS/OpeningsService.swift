//
//  OpeningsService.swift
//  MPS
//
//  Created by sandric on 16.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import Foundation

import Alamofire

import CoreData


class OpeningsService {
    
    /*
    static func fetchOpenings(callback: (Array<Dictionary<String,AnyObject>>) -> Void) {
        Alamofire.request(.GET, "http://localhost:8080/api/top")
            .responseJSON { response in
                if let openings = response.result.value as? Array<Dictionary<String,AnyObject>> {
                    callback(openings)
                }
        }
    }*/
    
    static func getGroups () -> [String] {
        return ["Open", "Semi-open", "Closed", "Semi-closed", "Indian-defence", "Flank"]
    }
    
    static func fetchOpeningsFromServer () {
        Alamofire.request(.GET, "http://localhost:8080/api/openings")
            .responseJSON { response in
                if let openings = response.result.value as? Array<Dictionary<String,AnyObject>> {
                    for opening in openings {
                        
                        let name = opening["name"] as! String
            
                        let group = opening["group"] as! String
                        
                        let moves = opening["moves"] as! [String]
                        let annotations = opening["annotations"] as! [String]
                        
                        let details = opening["details"] as! String
            
                        let startingMove = opening["starting_move"] as! Int
                        
                        OpeningsService.storeOpeningInCoreData(name, group: group, moves: moves, annotations: annotations, details: details, startingMove: startingMove)
                    }
                }
            }
    }
    
    
    static func storeOpeningInCoreData(name:String, group:String, moves:[String], annotations:[String], details:String, startingMove:Int)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("OpeningModel",
            inManagedObjectContext:managedContext)
        
        let openingModel = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        openingModel.setValue(name, forKey: "name")
        openingModel.setValue(group, forKey: "group")
        openingModel.setValue(moves.joinWithSeparator(";"), forKey: "moves")
        openingModel.setValue(annotations.joinWithSeparator(";"), forKey: "annotations")
        openingModel.setValue(details, forKey: "details")
        openingModel.setValue(startingMove, forKey: "startingMove")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Error saving opening \(error), \(error.userInfo)")
        }
    }
    
    
    static func fetchOpeningFromCoreData()
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
     
        var openingModels = [NSManagedObject]()
        
        let fetchRequest = NSFetchRequest(entityName: "OpeningModel")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            
            openingModels = results as! [NSManagedObject]
            
            print(openingModels)
        } catch let error as NSError {
            print("Error fetching opening \(error), \(error.userInfo)")
        }
    }
}