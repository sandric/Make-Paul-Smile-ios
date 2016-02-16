//
//  TopTableViewController.swift
//  MPS
//
//  Created by sandric on 16.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit


class TopTableViewController: UITableViewController {
    
    var topGames:[[String : AnyObject]] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TopService.fetchTopGames(self.onTopGamesFetched)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topGames.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TopCell", forIndexPath: indexPath)
        
        let topGame = self.topGames[indexPath.row]
        
        let group = topGame["group"] as? String
        let username = topGame["username"] as? String
        let score = topGame["score"] as? Int
        
        let groupLabel:UILabel = cell.viewWithTag(1) as! UILabel
        groupLabel.text = group
        
        let usernameLabel:UILabel = cell.viewWithTag(2) as! UILabel
        usernameLabel.text = username
        
        let scoreLabel:UILabel = cell.viewWithTag(3) as! UILabel
        scoreLabel.text = "\(score!)"
        
        return cell
    }
    
    
    func onTopGamesFetched(results : Array<Dictionary<String,AnyObject>>) {
        self.topGames = results
        self.tableView.reloadData()
    }
    
    @IBAction func refreshBarButtonPressed(sender: UIBarButtonItem) {
        TopService.fetchTopGames(self.onTopGamesFetched)
    }

}
