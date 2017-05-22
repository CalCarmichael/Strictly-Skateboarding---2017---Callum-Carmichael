//
//  FollowingTableViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 22/05/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase

class FollowingTableViewController: UITableViewController {
    
    
    @IBOutlet weak var followingTableView: UITableView!
    
    
    var databaseRef = FIRDatabase.database().reference()
    
    var user: FIRUser!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }



}
