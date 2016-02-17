//
//  TrainingViewController.swift
//  MPS
//
//  Created by sandric on 18.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {

    
    @IBOutlet var openingNameLabel: UILabel!
    
    
    
    var trainingGroup:String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.openingNameLabel.text = self.trainingGroup
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
