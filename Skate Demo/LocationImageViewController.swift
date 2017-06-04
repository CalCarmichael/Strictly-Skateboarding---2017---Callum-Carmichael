//
//  LocationImageViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 03/06/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase

class LocationImageViewController: UIViewController {

    @IBOutlet weak var skateLocationImage: UIImageView!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        
            loadSkateLocations()
        
            
        }
        
    
    
    
    func loadSkateLocations() {
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        
        let locationsRef = FIRDatabase.database().reference(withPath: "users").child("locations")
        
        locationsRef.observe(.value, with: { (snapshot) in
            
            
            
        })
    
    
        
    }

    
    //if statement??
  

}
