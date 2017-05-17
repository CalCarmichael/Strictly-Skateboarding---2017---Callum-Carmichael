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
        
        
//        
//        
//    
//        skateTitleText.text = skatepark?.name
//        
//        skateStyleText.text = skatepark?.subtitle
//        
//        
//        
//        let selected = pickerView.selectedRow(inComponent: 0)
//        
//        guard selected > 0 else {
//            print("select a type")
//            return
//        }
//
//        guard let skateTitleText = skateTitleText.text, let skateStyleText = skateStyleText.text else { return }
//        
//        guard skateTitleText.characters.count > 0, skateStyleText.characters.count > 0 else {
//            
//            return
//            
//        }
//        
//        locationRef.setValue(["name": skateTitleText, "subtitle": skateStyleText, "type": (selected - 1), "editable": true])
        

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
