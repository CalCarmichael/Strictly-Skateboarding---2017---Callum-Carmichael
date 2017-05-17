//
//  EditSaveSpotViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 16/05/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase

class EditSaveSpotViewController: UIViewController {
    
    
    @IBOutlet weak var skateTitleText: UITextField!
    
    @IBOutlet weak var skateStyleText: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var editSpotPopUP: UIView!
    
    var user: FIRUser!
    
    var skatepark: Skatepark!
    
    var parkId: String!
    
    let locationRef = FIRDatabase.database().reference(withPath: "personalLocations")
    
    var options = ["Select Type", "Skatepark", "Street Skating", "Favourite Spots"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(parkId)
        
        
      
        
    }

    
   
    
  
    @IBAction func updateSkateSpot(_ sender: Any) {
        
        guard let skateNameText = skateTitleText.text, let skateStyle = skateStyleText.text else { return }
        
        guard skateNameText.characters.count > 0, skateStyle.characters.count > 0 else {
            
            print("Complete all fields")
            
            return
            
        }
        
    }
    
    
    
        
        
//    let uid = FIRAuth.auth()?.currentUser?.uid
//        
//      //  let skateList = Skatepark(name: skateNameText, subtitle: skateStyle)
//        
//    let skateList: [String: Any] = ["name": skateNameText, "subtitle": skateStyle]
//        
//    let skatepark = skateList
//        
//    let key = self.skatepark.ref?.key
//        
//    let editItem = locationRef.child("users").child(uid!).child("/personalLocations/\(key)")
//        
////        editItem.updateChildValues(skateList.toAnyObject()) 
//        {
//        
//            (error, _) in
//            
//            if let error = error {
//                
//                print("error")
//                
//                
//            } else {
//                
//                print("success")
//                
//            }
//            
//        }
//
//    }
    
    
    @IBAction func deleteSkateSpot(_ sender: Any) {
    }
    
    

}


extension EditSaveSpotViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
}

extension EditSaveSpotViewController: UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    
}
