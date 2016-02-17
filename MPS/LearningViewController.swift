//
//  LearningViewController.swift
//  MPS
//
//  Created by sandric on 17.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

class LearningViewController: UIViewController, BoardViewControllerDelegate {
    
    
    @IBOutlet var openingNameLabel: UILabel!
    
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var movesTextView: UITextView!
    
    @IBOutlet var boardView: BoardView!
    

    @IBAction func reloadButtonPressed(sender: UIButton) {
        self.generateBoardView()
    }
    
    
    @IBAction func playButtonPressed(sender: UIButton) {
        if self.isPlaying {
            self.boardView.stop()
            self.playButton.setTitle("play", forState:.Normal)
            self.stepButton.enabled = true
        } else {
            self.boardView.play()
            self.playButton.setTitle("stop", forState:.Normal)
            self.stepButton.enabled = false
        }
        
        self.isPlaying = !self.isPlaying
    }
    @IBOutlet var playButton: UIButton!
    
    
    @IBAction func stepButtonPressed(sender: UIButton) {
        self.boardView.step()
    }
    @IBOutlet var stepButton: UIButton!
    
    
    
    
    var opening:Opening!
    
    var isPlaying = false
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.openingNameLabel.text = opening.name
        
        self.generateBoardView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func generateBoardView () {
        self.boardView.generate(self.opening, type:"learning", viewControllerDelegate:self)
    
        self.movesTextView.text = ""
        self.playButton.setTitle("play", forState:.Normal)
        
        self.stepButton.enabled = true;
        self.playButton.enabled = true;
        
        self.isPlaying = false;
    }
    
    
    
    
    
    func displayInfoMessage (message:String) {
        self.infoLabel.text = message;
    }
    
    func displayMoveNotation (moveNotation:String) {
        self.movesTextView.text = self.movesTextView.text + " " + moveNotation
    }
    
    func onBoardGenerated () {
        self.boardView.draw()
    }
    
    func onPlayerMadeMove () {
        self.boardView.draw()
    }
    
    func onPlayerMadeMistake () {
    }
    
    func onComputerMadeMove () {
        self.boardView.draw()
    }
    
    func onGameEnded () {
        self.stepButton.enabled = false
        self.playButton.enabled = false
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ResultsSegue" {
            
            let resultsViewController:ResultsViewController = segue.destinationViewController as! ResultsViewController
            resultsViewController.opening = self.opening
        }
    }
    
    
}
