//
//  SettingTableViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 30/04/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        navigationItem.title = "Edit Profile"
    
        getCurrentUser()
    
    }
    
    //Displaying user information
    
    func getCurrentUser() {
        
        Api.User.observeCurrentUser { (user) in
            
            self.usernameTextField.text = user.username
            
            self.emailTextField.text = user.email
            
            if let profileUrl = URL(string: user.profileImageUrl!) {
            
            self.profileImage.sd_setImage(with: profileUrl)
                
            }
            
        }
        
    }
    
    @IBAction func saveButton_TouchUpInside(_ sender: Any) {
    }
    
    @IBAction func logoutButton_TouchUpInside(_ sender: Any) {
    }
    
    

}
