//
//  ResultsViewController.swift
//  MPS
//
//  Created by sandric on 18.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    
    @IBOutlet var resultsLabel: UILabel!
    
    @IBOutlet var groupLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    
    @IBOutlet var previousBestGameGroupLabel: UILabel!
    @IBOutlet var previousBestGameScoreLabel: UILabel!
    
    
    
    @IBAction func OKButtonPressed(sender: UIButton) {
    }
    
    
    
    var group:String!
    var score:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.groupLabel.text = self.group
        self.scoreLabel.text = "\(self.score)"
        
        self.previousBestGameGroupLabel.text = "Best " + self.group + " score:"
        
        var bestScore = 0
        
        if let previousBestGame = ProfileService.getBestGame(self.group) {
        
            bestScore = previousBestGame["score"] as! Int
            
            if (self.score > bestScore) {
                self.resultsLabel.text = "You increased your previous result in " + self.group + " game. Good Job!"
                bestScore = self.score
            } else if (self.score == bestScore) {
                self.resultsLabel.text = "You repeated your previous result in " + self.group + " game. Just one point to succeed!"
            } else {
                self.resultsLabel.text = "You can and actually already did better in " + self.group + " game. I'm disappointed..."
            }
            
            self.previousBestGameScoreLabel.text = "\(bestScore)"
            
        } else {
            self.resultsLabel.text = "Looks like its your first result in " + self.group + " game. Great!"
            bestScore = self.score
        }

        self.previousBestGameScoreLabel.text = "\(bestScore)"
        
        if bestScore == self.score {
            ProfileService.setBestGame(self.group, score: bestScore)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
