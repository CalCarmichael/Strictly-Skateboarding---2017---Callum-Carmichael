//
//  SaveSpotViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 12/04/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase
import Mapbox
import IBAnimatable
import ProgressHUD
import PKHUD

class SaveSpotViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var skateTitleText: UITextField!
    @IBOutlet weak var skateStyleText: UITextField!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var saveSpotPopUpView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    
    @IBOutlet weak var shadowView: UIView!
    
    var options = ["Select Type", "Skatepark", "Street Skating", "Favourite Spots"]
    
    var skateparks = [Skatepark]()
    
    var user: FIRUser!
    
    var effect: UIVisualEffect!
    
    var locationManager = CLLocationManager()
    
    let locationsRef = FIRDatabase.database().reference(withPath: "locations")

    override func viewDidLoad() {
        super.viewDidLoad()

        saveSpotPopUpView.alpha = 0
        shadowView.alpha = 0
        
       
        saveSpotPopUpView.layer.masksToBounds = true
        
        skateTitleText.delegate = self
        skateStyleText.delegate = self
        
        
        addButton.layer.cornerRadius = 6
        
        self.addButton.layer.shadowColor = UIColor.black.cgColor
        self.addButton.layer.shadowOpacity = 0.2
        self.addButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.addButton.layer.shadowRadius = 5
        self.addButton.layer.shadowPath = UIBezierPath(roundedRect: self.addButton.bounds, cornerRadius: 10).cgPath
        
        self.shadowView.layer.shadowColor = UIColor.black.cgColor
        self.shadowView.layer.shadowOpacity = 0.5
        self.shadowView.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.shadowView.layer.shadowRadius = 5
        self.shadowView.layer.shadowPath = UIBezierPath(roundedRect: self.shadowView.bounds, cornerRadius: 10).cgPath
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        animateVisualEffectView()
        
        animateVisualEffect()
        
        
    }
    
    
    func textFieldShouldReturn(_ skateTitleText: UITextField) -> Bool {
        skateTitleText.resignFirstResponder()
        return true
    }
   
    
    
    func animateVisualEffectView() {
        
        UIView.animate(withDuration: 0.5) { 
            
            self.visualEffect.alpha = 1
            self.visualEffect.transform = CGAffineTransform.identity
            
        }
        
    }
    
    //Animating pop up in and visual effect
    
    func animateVisualEffect() {
        
        shadowView.center = self.shadowView.center
        shadowView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
      
        saveSpotPopUpView.center = self.saveSpotPopUpView.center
        saveSpotPopUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        
        
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            
            
            self.shadowView.alpha = 1
            self.shadowView.transform = CGAffineTransform.identity
            
            self.saveSpotPopUpView.alpha = 1
            self.saveSpotPopUpView.transform = CGAffineTransform.identity

            
        }, completion: nil)
        
        
    }
    
    

    
    
    
    func dismissAnimation(){
        
        
    }
    
    
    
    
    @IBAction func closeButton_TouchUpInside(_ sender: Any) {
        
        
    
       dismiss(animated: true, completion: nil)

        
//        let transition: CATransition = CATransition()
//        transition.duration = 1
//        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        transition.type = kCATransitionReveal
//        transition.subtype = kCATransitionFade
//        self.view.window!.layer.add(transition, forKey: nil)
//        self.dismiss(animated: false, completion: nil)

        
    }
    

    @IBAction func addPinAndSaveLocation(_ sender: Any) {
        
       
    
        let userLocationCoordinates = CLLocationCoordinate2DMake((locationManager.location?.coordinate.latitude)!, (locationManager.location?.coordinate.longitude)!)
        
        let pinForUserLocation = MGLPointAnnotation()
        
        pinForUserLocation.coordinate = userLocationCoordinates
        
        let selected = pickerView.selectedRow(inComponent: 0)
        
        guard selected > 0 else {
            
            ProgressHUD.showError("Select A SkateType")
            
            print("select a type")
            
            return 
            
        }
        
      guard let skateTitleText = skateTitleText.text, let skateStyleText = skateStyleText.text else { return }
    
        guard skateTitleText.characters.count > 0, skateStyleText.characters.count > 0 else {
            
            
            ProgressHUD.showError("Please Fill All Fields")
            
            return
            
        }
        
        //When the user clicks the button, send the CLLocation Coordinate 2D make to firebase against their user ID
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        
        let locationsRef = FIRDatabase.database().reference().child("users").child(uid).child("personalLocations").childByAutoId()
    
    
        locationsRef.setValue(["lat": locationManager.location?.coordinate.latitude, "lng": locationManager.location?.coordinate.longitude, "name": skateTitleText, "subtitle": skateStyleText, "type": (selected - 1), "editable": true, "did": "test"])
    
        
    }
    
    
    
    
    @IBAction func addButton_TouchUpInside(_ sender: Any) {
        
    
        dismiss(animated: true, completion: nil)
    
    }
    

}



extension SaveSpotViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
}

extension SaveSpotViewController: UIPickerViewDataSource {
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    
}

