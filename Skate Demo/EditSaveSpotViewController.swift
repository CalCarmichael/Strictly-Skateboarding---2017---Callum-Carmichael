//
//  EditSaveSpotViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 16/05/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase

protocol DeleteVCDelegate {
    func wholeRefresh()
}

class EditSaveSpotViewController: UIViewController  {
    
    
    @IBOutlet weak var skateTitleText: UITextField!
    
    @IBOutlet weak var skateStyleText: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var editSpotPopUP: UIView!
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var blackBackgroundView: UIView!
    
    @IBOutlet weak var wholeViewAnim: UIView!
    
    @IBOutlet weak var shadowlayer2: UIView!
    
    
    
    var user: FIRUser!
    
    var skatepark: Skatepark!
    
    var parkId: String!
    
    var ref: FIRDatabaseReference!
    
    var options = ["Select Type", "Skatepark", "Street Skating", "Favourite Spots"]
    
    var delegate: DeleteVCDelegate?

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        wholeViewAnim.alpha = 0
        
        shadowlayer2.alpha = 0
        
        wholeViewAnim.layer.masksToBounds = true
        
        ref = FIRDatabase.database().reference(withPath: "users").child(Api.User.CURRENT_USER!.uid).child("personalLocations/\(parkId!)")
       
        ref.observe(.value, with: { [unowned self] snapshot in
            
            guard let _ = snapshot.value as? [String: Any] else { return }
        
            self.skatepark = Skatepark(snapshot: snapshot)
            
            
            self.skateTitleText.text = self.skatepark.name
            self.skateStyleText.text = self.skatepark.subtitle
            
            
            
            self.setPickerView()
            
           
            
            
            //UI
            
            self.updateButton.layer.cornerRadius = 6
            self.deleteButton.layer.cornerRadius = 6
            
            
            self.updateButton.layer.shadowColor = UIColor.black.cgColor
            self.updateButton.layer.shadowOpacity = 0.2
            self.updateButton.layer.shadowOffset = CGSize(width: 0, height: 5)
            self.updateButton.layer.shadowRadius = 5
            self.updateButton.layer.shadowPath = UIBezierPath(roundedRect: self.updateButton.bounds, cornerRadius: 10).cgPath
            
            self.deleteButton.layer.shadowColor = UIColor.red.cgColor
            self.deleteButton.layer.shadowOpacity = 0.2
            self.deleteButton.layer.shadowOffset = CGSize(width: 0, height: 5)
            self.deleteButton.layer.shadowRadius = 5
            self.deleteButton.layer.shadowPath = UIBezierPath(roundedRect: self.deleteButton.bounds, cornerRadius: 10).cgPath
            
            self.wholeViewAnim.layer.shadowColor = UIColor.black.cgColor
            self.wholeViewAnim.layer.shadowOpacity = 0.5
            self.wholeViewAnim.layer.shadowOffset = CGSize(width: 0, height: 5)
            self.wholeViewAnim.layer.shadowRadius = 5
            self.wholeViewAnim.layer.shadowPath = UIBezierPath(roundedRect: self.wholeViewAnim.bounds, cornerRadius: 10).cgPath
            
            self.shadowlayer2.layer.shadowColor = UIColor.black.cgColor
            self.shadowlayer2.layer.shadowOpacity = 0.5
            self.shadowlayer2.layer.shadowOffset = CGSize(width: 0, height: 5)
            self.shadowlayer2.layer.shadowRadius = 5
            self.shadowlayer2.layer.shadowPath = UIBezierPath(roundedRect: self.shadowlayer2.bounds, cornerRadius: 10).cgPath

            
            
            
        })
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        animateVisualEffect()
        
        
    }
    
    func animateVisualEffect() {
        
        wholeViewAnim.center = self.wholeViewAnim.center
        wholeViewAnim.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        
        
        shadowlayer2.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            
            
            self.wholeViewAnim.alpha = 1
            self.wholeViewAnim.transform = CGAffineTransform.identity
            
            self.shadowlayer2.alpha = 1
            self.shadowlayer2.transform = CGAffineTransform.identity
            
           
            
            
        }, completion: nil)
        
        
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
        
        
        //        guard let skateTitleText = skateTitleText.text, let skateStyleText = skateStyleText.text else { return }
        //
        //        guard skateTitleText.characters.count > 0, skateStyleText.characters.count > 0 else {
        //
        //            return
        //            
        //        }
        
        
        
        skatepark.name = skateTitleText.text!
        
        skatepark.subtitle = skateStyleText.text!
        
        
        skatepark.type = SkateType(rawValue: pickerView.selectedRow(inComponent: 0) - 1)!
        
        
        ref.setValue(skatepark.dictionaryValues())
        
        dismiss(animated: true, completion: nil)
        
    
    }
    
    
    @IBAction func cancelView(_ sender: Any) {
        
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        
    }
    

    
    @IBAction func deleteSkateSpot(_ sender: Any) {
        
        
        
        
        ref = FIRDatabase.database().reference(withPath: "users").child(Api.User.CURRENT_USER!.uid).child("personalLocations/\(parkId!)")
        
        ref.observe(.value, with: { (snapshot) in
            

            
            self.ref.setValue(nil)
            
            let alert = UIAlertController(title: "Spot Deleted!", message: "Hit refresh to see the changes on your map!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            
            self.dismiss(animated: true, completion: nil)
            
            
            
            
            
            self.delegate?.wholeRefresh()
            
         //   self.delegate?.mainRefresh()
            
            print("CheckWorking")
            
            
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
