//
//  TopTableViewController.swift
//  MPS
//
//  Created by sandric on 16.02.16.
//  Copyright © 2016 sandric. All rights reserved.
//

import UIKit

import Alamofire


class TopTableViewController: UITableViewController {
    
    var topGames:[[String : AnyObject]] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchTopGames()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    
    func fetchTopGames () {
        Alamofire.request(.GET, "http://localhost:8080/api/top")
            .responseJSON { response in
                if let topResults = response.result.value as? Array<Dictionary<String,AnyObject>> {
                    self.topGames = topResults;
                    self.tableView.reloadData()
                }
        }
    }
    
    
    @IBAction func refreshBarButtonPressed(sender: UIBarButtonItem) {
        self.fetchTopGames()
    }

}
