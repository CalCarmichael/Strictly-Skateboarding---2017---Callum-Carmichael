//
//  SettingTableViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 30/04/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import ProgressHUD

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
    
        if let profileImg = self.profileImage.image, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            
        AuthService.updateUserInfo(username: usernameTextField.text!, email: emailTextField.text!, imageData: imageData, onSuccess: {
                ProgressHUD.showSuccess("Success")
            
            }, onError: { (errorMessage) in
                
                ProgressHUD.showError(errorMessage)
                
            })
            
        }
    
    }
    
    @IBAction func logoutButton_TouchUpInside(_ sender: Any) {
    }
    
    @IBAction func changeProfilePhoto_TouchUpInside(_ sender: Any) {
    
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    
    
    }
    

}

extension SettingTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("did finish pick")
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            profileImage.image = image
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
