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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("OpeningsGroupsCellIdentifier", forIndexPath: indexPath)

        cell.textLabel!.text = self.openingsGroups[indexPath.row]

        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("OpeningsSegue", sender: self)
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "OpeningsSegue" {
            
            let openingsViewController:OpeningsTableViewController = segue.destinationViewController as! OpeningsTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            openingsViewController.selectedOpeningsGroup = self.openingsGroups[indexPath.row]
        }
    }
}
