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
    
    var ref: FIRDatabaseReference!
    
    var options = ["Select Type", "Skatepark", "Street Skating", "Favourite Spots"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let uid = FIRAuth.auth()!.currentUser!.uid

        ref = FIRDatabase.database().reference(withPath: "users").child("dKq0eabTZnRdaHlJ7KO3NF5UE7T2").child("personalLocations/-KkWF-_3qKlEBB9GNwRO")
       
        ref.observe(.value, with: { [unowned self] snapshot in
            self.skatepark = Skatepark(snapshot: snapshot)
            self.skateTitleText.text = self.skatepark.name
        })
        
    
        
        
        
        
    }
    
  
    @IBAction func updateSkateSpot(_ sender: Any) {
        
       
        let selected = pickerView.selectedRow(inComponent: 0)
        
//        guard selected > 0 else {
//            print("select a type")
//            return
//        }
        
        skatepark.name = skateTitleText.text!
        
//        guard let skateTitleText = skateTitleText.text, let skateStyleText = skateStyleText.text else { return }
//        
//        guard skateTitleText.characters.count > 0, skateStyleText.characters.count > 0 else {
//            
//            return
//            
//        }
        
        ref.setValue(skatepark.dictionaryValues())
        
//        let uid = FIRAuth.auth()!.currentUser!.uid
//        
//        let key = skatepark.ref!.key
//        
//        //Have to get in the data name, subtitle type editable and location
//        
//        let skateUpdate = FIRDatabase.database().reference().child("users").child(uid).child("personalLocations/\(key)")
//        
//        skateUpdate.observe(.value, with: { snapshot in
//        
//    }
    
    }



    
    
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
