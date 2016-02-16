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
                    NSUserDefaults.standardUserDefaults()
                        .setObject(profileResults, forKey: "profile")
                    
                    callback()
            }
        }
    }
}