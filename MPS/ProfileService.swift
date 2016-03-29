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
    
    static func signIn (username:String, password:String, callbackSuccess : (Void) -> (Void), callbackError : (String) -> (Void)) {
        
        let parameters = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(.POST, "http://localhost:8080/api/sessions/", parameters: parameters)
            .validate()
            
            .responseJSON { response in
                switch response.result {
                case .Success:

                    ProfileService.setProfile(response.result.value as! [String : AnyObject])
                
                    callbackSuccess()
                    
                case .Failure:
                    
                    let errorInfo = NSString(data: response.data!, encoding: NSUTF8StringEncoding)! as String
                    let formattedErrorInfo = errorInfo[errorInfo.startIndex.advancedBy(1)...errorInfo.endIndex.advancedBy(-2)]
                    
                    callbackError(formattedErrorInfo);
                }
            }
    }
    
    static func signUp (username:String, password:String, callbackSuccess : (Void) -> (Void), callbackError : (String) -> (Void)) {
        
        let parameters = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(.POST, "http://localhost:8080/api/users/", parameters: parameters)
            .validate()
            
            .responseJSON { response in
                switch response.result {
                case .Success:
                    
                    ProfileService.setProfile(response.result.value as! [String : AnyObject])
                    
                    callbackSuccess()
                    
                case .Failure:
                    
                    let errorInfo = NSString(data: response.data!, encoding: NSUTF8StringEncoding)! as String
                    let formattedErrorInfo = errorInfo[errorInfo.startIndex.advancedBy(1)...errorInfo.endIndex.advancedBy(-2)]
                    
                    callbackError(formattedErrorInfo);
                }
        }
    }
    
    
    static func updateProfile (callback : (Void) -> (Void)) {
        Alamofire.request(.PATCH, "http://localhost:8080/api/users/" + (ProfileService.getProfile()["id"] as! String), parameters: ProfileService.getProfile(), encoding: .JSON)
            .responseJSON { response in
                
                ProfileService.fetchProfileToUserDefaults(callback);
            }
    }
    
    
    static func fetchProfileToUserDefaults (callback : (Void) -> (Void)) {
        Alamofire.request(.GET, "http://localhost:8080/api/users/" + (ProfileService.getProfile()["id"] as! String))
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
    
    static func unsetProfile () {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("profile")
    }
    
    static func profileExists () -> Bool {
        return NSUserDefaults.standardUserDefaults().objectForKey("profile") != nil
    }
    
    
    
    static func getBestGame () -> [String:AnyObject] {
        let profile = ProfileService.getProfile()
        
        return profile["best_game"] as! [String:AnyObject]
    }
    
    static func getBestGame (groupname:String) -> [String:AnyObject]? {
        let profile = ProfileService.getProfile()
        
        if let bestGames = profile["best_games"] as? [[String:AnyObject]] {
            for bestGame in bestGames {
                if bestGame["groupname"] as! String == groupname {
                    return bestGame
                }
            }
        }
        
        return nil
    }
    
    static func setBestGame (groupname:String, score:Int) {
        var profile = ProfileService.getProfile()
 
        if let bestGame = profile["best_game"] as? [String:AnyObject] {
            if (bestGame["score"] as! Int) < score {
                profile["best_game"] = ["groupname": groupname, "score": score];
            }
        } else {
            profile["best_game"] = ["groupname": groupname, "score": score];
        }
        
        if var bestGames = profile["best_games"] as? [[String:AnyObject]] {
            for (index, bestGame) in bestGames.enumerate() {
                if bestGame["groupname"] as! String == groupname {
                    bestGames.removeAtIndex(index)
                    break
                }
            }
            
            bestGames.append(["groupname": groupname, "score": score])
            
            profile["best_games"] = bestGames
        }
        
        ProfileService.setProfile(profile)
    }
}