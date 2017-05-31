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
        
        
        
        ref = FIRDatabase.database().reference(withPath: "users").child(Api.User.CURRENT_USER!.uid).child("personalLocations/\(parkId!)")
       
        ref.observe(.value, with: { [unowned self] snapshot in
            
            guard let _ = snapshot.value as? [String: Any] else { return }
        
            self.skatepark = Skatepark(snapshot: snapshot)
            
            
            self.skateTitleText.text = self.skatepark.name
            self.skateStyleText.text = self.skatepark.subtitle
            
            
            
            self.setPickerView()
            
            
            
        })
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        animateVisualEffect()
        
        
    }
    

    
    func setPickerView() {
        
        for (index, option) in options.enumerated() {
            if option == skatepark.type.getString() {
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
            
            
        }
        
    }
    
  
    @IBAction func updateSkateSpot(_ sender: Any) {
        
       
        let selected = pickerView.selectedRow(inComponent: 0)
        
        guard selected > 0 else {
            print("select a type")
            return
        }
        
        skatepark.name = skateTitleText.text!
        
        skatepark.subtitle = skateStyleText.text!
        
        
        skatepark.type = SkateType(rawValue: pickerView.selectedRow(inComponent: 0) - 1)!
        
        
        
//        guard let skateTitleText = skateTitleText.text, let skateStyleText = skateStyleText.text else { return }
//        
//        guard skateTitleText.characters.count > 0, skateStyleText.characters.count > 0 else {
//            
//            return
//            
//        }
            
        
        ref.setValue(skatepark.dictionaryValues())
        
   
    
    }
    
    
    @IBAction func cancelView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func animateVisualEffect() {
        
        
        editSpotPopUP.center = self.editSpotPopUP.center
        editSpotPopUP.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            
            
            self.editSpotPopUP.alpha = 1
            self.editSpotPopUP.transform = CGAffineTransform.identity
            
            
        }, completion: nil)
        
        
    }

    
    

    
    @IBAction func deleteSkateSpot(_ sender: Any) {
        
        ref = FIRDatabase.database().reference(withPath: "users").child(Api.User.CURRENT_USER!.uid).child("personalLocations/\(parkId!)")
        
        ref.observe(.value, with: { (snapshot) in
            

            
            self.ref.setValue(nil)
            
            
            

            print(snapshot)
            
            
            //Do an alert yes or no
            
            
        })
        
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
