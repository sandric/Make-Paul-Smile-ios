//
//  TrainingViewController.swift
//  MPS
//
//  Created by sandric on 18.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController, BoardViewControllerDelegate {

    
    @IBOutlet var openingNameLabel: UILabel!
    
    @IBOutlet var boardView: BoardView!
    
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var movesTextView: UITextView!
    
    @IBAction func endGameButtonPressed(sender: UIButton) {
        self.endTraining()
    }
    
    
    @IBOutlet var skipButton: UIButton!
    @IBAction func skipButtonPressed(sender: UIButton) {
        self.getRandomOpening()
    }
    
    
    @IBOutlet var hintButton: UIButton!
    @IBAction func hintButtonPressed(sender: UIButton) {
        self.boardView.highlightHint()
        self.decreaseScore()
    }
    
    @IBOutlet var openingsLeftLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    
    
    var trainingGroup:String!
    
    var openings:[Opening] = []
    
    var opening:Opening!
    
    var score:Int = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Training " + self.trainingGroup
        
        self.openings = OpeningsService.getOpenings(self.trainingGroup)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getRandomOpening()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func generateTraining () {
    
        self.boardView.generate(self.opening, type:"training", viewControllerDelegate:self)
    
        for cellView in self.boardView.subviews {
            let tapRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("cellViewPressed:"))
            cellView.addGestureRecognizer(tapRecognizer)
        }
    }
    
    
    
    
    func getRandomOpening () {
        let randomOpeningIndex:Int = Int(arc4random_uniform(UInt32(self.openings.count)))
    
        UILabel.transitionWithView(self.openingNameLabel, duration: 0.1, options: UIViewAnimationOptions.TransitionFlipFromTop, animations: {
            
                self.openingNameLabel.text = self.openings[randomOpeningIndex].name
            
            }, completion: { (finished: Bool) -> () in
                
                for (index, opening) in self.openings.enumerate() {
                    if opening.name == self.openingNameLabel.text {
                        self.opening = opening
                        self.openings.removeAtIndex(index)
                    }
                }
                
                self.openingsLeftLabel.text = "\(self.openings.count)"
                
                self.generateTraining()
        })
    }
    
    
    
    func endTraining () {
        self.performSegueWithIdentifier("ResultsSegue", sender:self)
    }
    
    
    
    func cellViewPressed (tapRecognizer:UITapGestureRecognizer) {
        self.boardView.cellViewPressed(tapRecognizer.view as! CellView)
    }
    
    
    
    
    func updateScoreLabel () {
        self.scoreLabel.text = "\(self.score)"
    }
    
    
    
    func increaseScore () {
        self.score++
        self.updateScoreLabel()
    }
    
    func decreaseScore () {
        self.score--
        self.updateScoreLabel()
    }
    
    func clearScore () {
        self.score = 0;
        self.updateScoreLabel()
    }
    
    
    
    
    func displayInfoMessage (message:String) {
        self.infoLabel.text = message
    }
    
    func displayMoveNotation (moveNotation:String) {
        self.movesTextView.text = self.movesTextView.text + " " + moveNotation
    }
    
    func onBoardGenerated () {
        self.boardView.draw()
    }
    
    func onPlayerMadeMove () {
        self.boardView.draw()
        self.increaseScore()
    }
    
    func onComputerMadeMove () {
        self.boardView.draw()
    }
    
    func onPlayerMadeMistake () {
        self.decreaseScore()
    }
    
    func onGameEnded () {
        self.infoLabel.text = "You won, great job!"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
