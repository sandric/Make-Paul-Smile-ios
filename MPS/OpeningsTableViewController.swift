//
//  OpeningsTableViewController.swift
//  MPS
//
//  Created by sandric on 16.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

class OpeningsTableViewController: UITableViewController {

    var selectedOpeningsGroupName:String!
    
    var openings:[Opening] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.openings = OpeningsService.getOpenings(self.selectedOpeningsGroupName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.openings.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OpeningsCellIdentifier", forIndexPath: indexPath)

        cell.textLabel!.text = self.openings[indexPath.row].name

        return cell
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("LearningSegue", sender: self)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LearningSegue" {
            
            let learningViewController:LearningViewController = segue.destinationViewController as! LearningViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            learningViewController.opening = self.openings[indexPath.row]
        }
    }
}
