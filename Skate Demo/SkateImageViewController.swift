//
//  SkateImageViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 04/06/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase

class SkateImageViewController: UIViewController {
    
    var skateparks = [Skatepark]()
    
    var parkId: String!
    
    @IBOutlet weak var skateLocation: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        getLocationImage()
        
        
    }

    
    func getLocationImage() {
    
        let skateImage = FIRDatabase.database().reference(withPath: "locations")
        
        skateImage.observe(.value, with: { (snapshot) in
            
         //   print(snapshot)
                
                
          
            
        })
    
    
    }
    
    

}
