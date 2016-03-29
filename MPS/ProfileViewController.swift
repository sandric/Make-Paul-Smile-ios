//
//  ProfileViewController.swift
//  MPS
//
//  Created by sandric on 16.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit


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
    
    @IBAction func updateBarButtonPressed(sender: UIBarButtonItem) {
        ProfileService.updateProfile(self.onUserDefaultsChanged)
    }
    
    
    
    @IBAction func signOutButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("SignOutSegue", sender: self)
    }
    
    
    func displayProfileUserDefaults () {
        
        print("drawinf...");
        
        if let profileUserDefaults = NSUserDefaults.standardUserDefaults()
            .objectForKey("profile") as? NSDictionary
        {
            if let username = profileUserDefaults["name"] as? String
            {
                self.usernameLabel.text = username
            }
            
            if let best_game = profileUserDefaults["best_game"] as? NSDictionary
            {
                if let best_group = best_game["groupname"] as? String {
                    self.bestGameGroupLabel.text = best_group
                }
                
                if let best_score = best_game["score"] as? Int {
                    self.bestGameScoreLabel.text = "\(best_score)"
                }
            }
            
            if let best_games = profileUserDefaults["best_games"] as? NSArray
            {
                for best_game_optional in best_games {
                    if let best_game = best_game_optional as? NSDictionary {
                        
                        if let best_group = best_game["groupname"] as? String {
                            
                            switch best_group {
                                
                                case "Open":
                                    self.bestOpenGameScore.text = "\(best_game["score"] as! Int)"

                                case "Semi-open":
                                    self.bestSemiOpenGameScore.text = "\(best_game["score"] as! Int)"
                                
                                case "Closed":
                                    self.bestClosedGameScore.text = "\(best_game["score"] as! Int)"

                                case "Semi-closed":
                                    self.bestSemiClosedGameScore.text = "\(best_game["score"] as! Int)"

                                case "Indian-defence":
                                    self.bestIndianDefenceGameScore.text = "\(best_game["score"] as! Int)"

                                case "Flank":
                                    self.bestFlankGameScore.text = "\(best_game["score"] as! Int)"
                                
                                default:
                                    print("No played games.")

                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func onUserDefaultsChanged () {
        self.displayProfileUserDefaults()
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            case "SignOutSegue":
                print("Clearing user data")
                ProfileService.unsetProfile()
                
            default:
                print("Unknown segue.")
        }
    }
}
