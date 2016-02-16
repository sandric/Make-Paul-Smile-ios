//
//  TopService.swift
//  MPS
//
//  Created by sandric on 16.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import Foundation

import Alamofire


class TopService {
    static func fetchTopGames(callback: (Array<Dictionary<String,AnyObject>>) -> Void) {
        Alamofire.request(.GET, "http://localhost:8080/api/top")
            .responseJSON { response in
                if let topResults = response.result.value as? Array<Dictionary<String,AnyObject>> {
                    callback(topResults)
                }
        }
    }
}