//
//  ProfileService.swift
//  MPS
//
//  Created by sandric on 16.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import Foundation

import Alamofire

class ProfileService {
    
    static func fetchProfileToUserDefaults (callback : (Void) -> (Void)) {
        Alamofire.request(.GET, "http://localhost:8080/api/users/7")
            .responseJSON { response in
                if let profileResults = response.result.value {
                    
                    ProfileService.setProfile(profileResults as! [String : AnyObject])
                    
                    callback()
            }
        }
    }
    
    static func getProfile () -> [String:AnyObject] {
        return NSUserDefaults.standardUserDefaults().objectForKey("profile") as! [String:AnyObject]
    }
    
    static func setProfile (profile:[String:AnyObject]) {
        NSUserDefaults.standardUserDefaults().setObject(profile, forKey: "profile")
    }
    
    
    static func getBestGame () -> [String:AnyObject] {
        let profile = ProfileService.getProfile()
        
        return profile["best_game"] as! [String:AnyObject]
    }
    
    static func getBestGame (group:String) -> [String:AnyObject]? {
        let profile = ProfileService.getProfile()
        
        if let bestGamesByGroup = profile["best_games_by_group"] as? [[String:AnyObject]] {
            for bestGame in bestGamesByGroup {
                if bestGame["group"] as! String == group {
                    return bestGame
                }
            }
        }
        
        return nil
    }
    
    static func setBestGame (group:String, score:Int) {
        var profile = ProfileService.getProfile()
        
        if var bestGamesByGroup = profile["best_games_by_group"] as? [[String:AnyObject]] {
            for (index, bestGame) in bestGamesByGroup.enumerate() {
                if bestGame["group"] as! String == group {
                    bestGamesByGroup.removeAtIndex(index)
                    break
                }
            }
            
            bestGamesByGroup.append(["group": group, "score": score])
            
            profile["best_games_by_group"] = bestGamesByGroup
            
            ProfileService.setProfile(profile)
        }
    }
}