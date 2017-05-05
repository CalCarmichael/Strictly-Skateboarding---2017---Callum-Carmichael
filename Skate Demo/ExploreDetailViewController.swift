//
//  FeedDetailViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 05/05/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit

class ExploreDetailViewController: UIViewController {
    
    var postId = ""
    var post = Post()
    var user = User()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

       loadSpecificPost()
        
        
    }

    func loadSpecificPost() {
        
        Api.Post.observePost(withId: postId) { (post) in
            
            guard let postUid = post.uid else {
                return
            }
            
            self.getUser(uid: postUid, completed: {
                
                self.post = post
                
                self.tableView.reloadData()
                
            })
            
        }
        
    }
    
    func getUser(uid: String, completed: @escaping () -> Void) {
        
        Api.User.observeUser(withId: uid, completion: {
            user in
            self.user = user 
            completed()
            
        })
        
    }
    
 
}

extension ExploreDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! FeedTableViewCell
        
        //Posting the user information from Folder Views - FeedTableViewCell
        
        
        cell.post = post
        cell.user = user
        //cell.delegate = self
        return cell
        
    }
    
}
