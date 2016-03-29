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
    
    static func getGroupNames () -> [String] {
        return ["Open", "Semi-open", "Closed", "Semi-closed", "Indian-defence", "Flank"]
    }
    
    
    static func destroyOpenings () {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "OpeningModel")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.executeRequest(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    static func getOpenings () -> [Opening] {
        
        var openings:[Opening] = []
        
        let openingModels = OpeningsService.fetchOpeningFromCoreData()
        
        for openingModel in openingModels {
            openings.append(OpeningsService.parseOpeningFromNSManagedObject(openingModel))
        }
        
        return openings
    }
    
    static func getOpenings (groupname:String) -> [Opening] {
        
        var openings:[Opening] = []
        
        let openingModels = OpeningsService.fetchOpeningFromCoreData(groupname)
        
        for openingModel in openingModels {
            openings.append(OpeningsService.parseOpeningFromNSManagedObject(openingModel))
        }
        
        return openings
    }
    
    
    static func parseOpeningFromNSManagedObject(openingModel:NSManagedObject) -> Opening {
        let opening:Opening = Opening(
            name: openingModel.valueForKey("name") as? String,
            andMoves: (openingModel.valueForKey("moves") as! String).componentsSeparatedByString(";"),
            andAnnotations: (openingModel.valueForKey("annotations") as! String).componentsSeparatedByString(";"),
            andStartingMove: openingModel.valueForKey("startingMove") as! Int,
            andDetails: openingModel.valueForKey("details") as? String
        )
        
        return opening
    }
    
    
    static func fetchOpeningsFromServer () {
        Alamofire.request(.GET, "http://localhost:8080/api/openings")
            .responseJSON { response in
                if let openings = response.result.value as? Array<Dictionary<String,AnyObject>> {
                    
                    OpeningsService.destroyOpenings()
                    
                    for opening in openings {
                        
                        let name = opening["name"] as! String
            
                        let groupname = opening["groupname"] as! String
                        
                        let moves = opening["moves"] as! [String]
                        let annotations = opening["annotations"] as! [String]
                        
                        let details = opening["details"] as! String
            
                        let startingMove = opening["starting_move"] as! Int
                        
                        OpeningsService.storeOpeningInCoreData(name, groupname: groupname, moves: moves, annotations: annotations, details: details, startingMove: startingMove)
                    }
                }
            }
    }
    
    
    static func storeOpeningInCoreData(name:String, groupname:String, moves:[String], annotations:[String], details:String, startingMove:Int)
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("OpeningModel",
            inManagedObjectContext:managedContext)
        
        let openingModel = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        openingModel.setValue(name, forKey: "name")
        openingModel.setValue(groupname, forKey: "groupname")
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
    
    
    static func fetchOpeningFromCoreData() -> [NSManagedObject]
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
     
        var openingModels = [NSManagedObject]()
        
        let fetchRequest = NSFetchRequest(entityName: "OpeningModel")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            
            openingModels = results as! [NSManagedObject]
            
        } catch let error as NSError {
            print("Error fetching opening \(error), \(error.userInfo)")
        }
    
        return openingModels;
    }
    
    static func fetchOpeningFromCoreData(groupname:String) -> [NSManagedObject]
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        var openingModels = [NSManagedObject]()
        
        let fetchRequest = NSFetchRequest(entityName: "OpeningModel")
        
        fetchRequest.predicate = NSPredicate(format: "groupname == %@", groupname)
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            
            openingModels = results as! [NSManagedObject]
            
        } catch let error as NSError {
            print("Error fetching opening \(error), \(error.userInfo)")
        }
        
        return openingModels;
    }
}