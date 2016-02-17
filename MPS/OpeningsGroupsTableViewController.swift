//
//  OpeningsGroupsTableViewController.swift
//  MPS
//
//  Created by sandric on 16.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

class OpeningsGroupsTableViewController: UITableViewController {
    

    var openingsGroups:[String] = []
    
    var trainingGroup:String!
    
    
    @IBAction func trainButtonPressed (sender:UIButton) {
        
        self.trainingGroup = self.openingsGroups[sender.tag]
        
        performSegueWithIdentifier("TrainingSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.openingsGroups = OpeningsService.getGroups()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return openingsGroups.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("OpeningsGroupsCellIdentifier", forIndexPath: indexPath) as! OpeningGroupsTableViewCell

        cell.openingGroupLabel.text = self.openingsGroups[indexPath.row]
        
        cell.trainButton.tag = indexPath.row
        cell.trainButton.addTarget(self, action: "trainButtonPressed:", forControlEvents: .TouchUpInside)
        

        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("OpeningsSegue", sender: self)
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            case "OpeningsSegue":
                let openingsViewController:OpeningsTableViewController = segue.destinationViewController as! OpeningsTableViewController
                let indexPath = self.tableView.indexPathForSelectedRow!
                openingsViewController.selectedOpeningsGroup = self.openingsGroups[indexPath.row]
            
            case "TrainingSegue":
                let trainingViewController:TrainingViewController = segue.destinationViewController as! TrainingViewController
                trainingViewController.trainingGroup = self.trainingGroup
            
            default:
                print("Unknown segue.")
        }
    }
}
