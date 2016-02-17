//
//  ResultsViewController.swift
//  MPS
//
//  Created by sandric on 18.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    @IBOutlet var openingNameLabel: UILabel!
    
    @IBOutlet var openingDetailsTextView: UITextView!
    
    
    var opening:Opening!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.openingNameLabel.text = self.opening.name
        
        self.openingDetailsTextView.text = self.opening.details
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
