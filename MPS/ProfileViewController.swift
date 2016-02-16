//
//  ProfileViewController.swift
//  MPS
//
//  Created by sandric on 16.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

import Alamofire

class ProfileViewController: UIViewController {

    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var bestGameGroupLabel: UILabel!
    @IBOutlet var bestGameScoreLabel: UILabel!
    
    @IBOutlet var bestOpenGameScore: UILabel!
    @IBOutlet var bestSemiOpenGameScore: UILabel!
    @IBOutlet var bestClosedGameScore: UILabel!
    @IBOutlet var bestSemiClosedGameScore: UILabel!
    @IBOutlet var bestIndianDefenceGameScore: UILabel!
    @IBOutlet var bestFlankGameScore: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayProfileUserDefaults()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func reloadBarButtomPressed(sender: UIBarButtonItem) {
        self.fetchProfileToUserDefaults()
    }
    
    
    func fetchProfileToUserDefaults () {
        Alamofire.request(.GET, "http://localhost:8080/api/users/7")
            .responseJSON { response in
                if let profileResults = response.result.value {
                    NSUserDefaults.standardUserDefaults()
                        .setObject(profileResults, forKey: "profile")
                    
                    self.displayProfileUserDefaults()
                }
        }
    }
    
    
    func displayProfileUserDefaults () {
        if let profileUserDefaults = NSUserDefaults.standardUserDefaults()
            .objectForKey("profile") as? NSDictionary
        {
            if let username = profileUserDefaults["name"] as? String
            {
                self.usernameLabel.text = username
            }
            
            if let best_game = profileUserDefaults["best_game"] as? NSDictionary
            {
                if let best_group = best_game["group"] as? String {
                    self.bestGameGroupLabel.text = best_group
                }
                
                if let best_score = best_game["score"] as? Int {
                    self.bestGameScoreLabel.text = "\(best_score)"
                }
            }
            
            if let best_games_by_group = profileUserDefaults["best_games_by_group"] as? NSArray
            {
                for best_game_by_group_optional in best_games_by_group {
                    if let best_game_by_group = best_game_by_group_optional as? NSDictionary {
                        
                        if let best_group = best_game_by_group["group"] as? String {
                            
                            switch best_group {
                                
                                case "Open":
                                    self.bestOpenGameScore.text = "\(best_game_by_group["score"] as! Int)"

                                case "Semi-open":
                                    self.bestSemiOpenGameScore.text = "\(best_game_by_group["score"] as! Int)"
                                
                                case "Closed":
                                    self.bestClosedGameScore.text = "\(best_game_by_group["score"] as! Int)"

                                case "Semi-closed":
                                    self.bestSemiClosedGameScore.text = "\(best_game_by_group["score"] as! Int)"

                                case "Indian-defence":
                                    self.bestIndianDefenceGameScore.text = "\(best_game_by_group["score"] as! Int)"

                                case "Flank":
                                    self.bestFlankGameScore.text = "\(best_game_by_group["score"] as! Int)"
                                
                                default:
                                    print("No played games.")

                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    
    
    
}
