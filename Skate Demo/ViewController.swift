//
//  ViewController.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 15/03/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import UIKit
import Firebase
import Mapbox
import MapboxDirections
import MapKit
import UserNotifications



class ViewController: UIViewController, SideBarDelegate, MGLMapViewDelegate, DeleteVCDelegate {
    
    
    @IBOutlet weak var mapView: MGLMapView!
    
    var sideBar: SideBar = SideBar()
    
    var skateparks = [Skatepark]()
    
    var user: FIRUser!
    
    let locationManager = CLLocationManager()
    
    let locationsRef = FIRDatabase.database().reference(withPath: "locations")
    
    let directions = Directions.shared
    
    var annotation = MGLAnnotationView()
    
    var pointAnnotation = MGLPointAnnotation()
    
    var marker: String?
    
    var ref: FIRDatabaseReference!
    
    var parkId: String!
    
    var skateId: String!
    
    var delegate: SideBarDelegate?
    
    
    
    //Filtering annotations for sidebar
    
    @IBOutlet weak var refreshButton: UIButton!
    
    let EditSaveSpotController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditVC") as! EditSaveSpotViewController
    
    
    func sideBarDidSelectButtonAtIndex(_ index: Int) {
        
    
        if let annotations = mapView.annotations {
            
            mapView.removeAnnotations(annotations)
            
        }
        
        for park in skateparks {
            
            if index == 0 {
                addAnnotation(park: park)
              //  marker = "AllBlack"
                
            }
            
            if index == 1 && park.type == .park {
                addAnnotation(park: park)
             //   marker = "AllSkateparks1"
                
            }
            
            if index == 2 && park.type == .street {
                addAnnotation(park: park)
             //   marker = "Skateparks"
            }
            
            //Change this to feature the users own personal spots they saved to firebase
            
            if index == 3 && park.type == .own {
                addAnnotation(park: park)
              //  marker = "Fav"
            }
            
            
            
            
            
        }
        
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        EditSaveSpotController.delegate = self
        
        
          marker = "SSPin"
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        
        
        let logo = UIImage(named: "SkateHeaderIcon1")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
    
        
        let SkateIcon = MGLPointAnnotation()
        mapView.addAnnotation(SkateIcon)
        

//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        imageView.contentMode = .scaleAspectFit
//        
//        let image = UIImage(named: "SNav")
//        imageView.image = image
//        navigationItem.titleView = imageView
        
        //Map
        
        
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        

        //Sidebar
        
        
        sideBar = SideBar(sourceView: self.view, skateItems: ["All Skate Spots", "Skateparks", "Street Skating", "Favourites"])
        sideBar.delegate = self
        
        
        // Passing firebase annotation data
        
    
        loadLocations()
        
        
        
        
    }
    
    
    
    
    
    func loadLocations() {
        
        view.sendSubview(toBack: mapView)
        
        locationsRef.observe(.value, with: { snapshot in
            self.skateparks.removeAll()
            
            if let annotations = self.mapView.annotations {
                
                self.mapView.removeAnnotations(annotations)
                
            }
            
            for item in snapshot.children {
                guard let snapshot = item as? FIRDataSnapshot else { continue }
                
                let newSkatepark = Skatepark(snapshot: snapshot)
                
                self.skateparks.append(newSkatepark)
                
                self.addAnnotation(park: newSkatepark)
            }
            
            self.loadCustomLocations()
            
            
            
        })
        

        
        
    }
    
    func loadCustomLocations() {
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        
        let userLocationsRef = FIRDatabase.database().reference(withPath: "users/\(uid)/personalLocations")
        
        userLocationsRef.observe(.value, with: { snapshot in
            
            
            for item in snapshot.children {
                guard let snapshot = item as? FIRDataSnapshot else { continue }
                
                let newSkatepark = Skatepark(snapshot: snapshot)
                
                self.skateparks.append(newSkatepark)
                
                self.addAnnotation(park: newSkatepark)
                
                
            }
        })
    }
    
    
    
    func wholeRefresh() {
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        
        let userLocationsRef = FIRDatabase.database().reference(withPath: "users/\(uid)/personalLocations")
        
        userLocationsRef.observe(.value, with: { snapshot in
            
            
            for item in snapshot.children {
                guard let snapshot = item as? FIRDataSnapshot else { continue }
                
                let newSkatepark = Skatepark(snapshot: snapshot)
                
                self.skateparks.append(newSkatepark)
                
                self.addAnnotation(park: newSkatepark)
                
                
            }
        })

        if let annotations = mapView.annotations {
            
            mapView.removeAnnotations(annotations)
            
        }
        
        for item in skateparks {
            
            self.addAnnotation(park: item)
            
        }

        
        
    }
    
    
    func mainRefresh() {
        
        
            
            loadLocations()
            
            annotationRefresh()
            
       
        
        
        
    }
    
  
    func annotationRefresh() {
    
        if let annotations = mapView.annotations {
            
            mapView.removeAnnotations(annotations)
            
        }
        
        for item in skateparks {
            
            self.addAnnotation(park: item)
            
        }
    
    }
    
    @IBAction func refresh(_ sender: Any) {
        
        
        buttonAnimate()
        
        loadLocations()
        
        annotationRefresh()
        
    }
    

        
    func buttonAnimate() {
        
        refreshButton.transform = CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.refreshButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
            
        })

        
    }
    

    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    func mapDirections(for park: Skatepark) {
        
        
        let regionDistance: CLLocationDistance = 1000;

        
        let regionSpan = MKCoordinateRegionMakeWithDistance(park.coordinate, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: park.coordinate, addressDictionary: nil)
        
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = park.name
        
        mapItem.openInMaps(launchOptions: options)
        
    }
    

    
    //Adding annotations on map
    
    func addAnnotation(park: Skatepark) {

        let point = SkateAnnotation()
        
        point.skatepark = park
        
        point.coordinate = park.coordinate

        point.title = park.name
        
        point.id = park.id
        
        point.subtitle = park.subtitle
        
        point.canEdit = park.editable
        
        point.photoUrl = park.photoUrl
        
        point.image = UIImage(named: "SkateAnnotation1")
        
        mapView.addAnnotation(point)
        
        mapView.selectAnnotation(point, animated: true)
        
    }
    

    @IBAction func sideBarButton(_ sender: Any) {
        
        if sideBar.isSideBarOpen == false {
            
            sideBar.showSideBar(true)
            
            sideBar.delegate?.sideBarWillOpen?()
            
        } else {
            
            if sideBar.isSideBarOpen == true {
                
                sideBar.showSideBar(false)
                
            }
        
        }
        
    }
    
    
    
//    //User can save their location
//    @IBAction func findUserLocationAndDropPin(_ sender: UIButton) {
//        
//        let userLocationCoordinates = CLLocationCoordinate2DMake((locationManager.location?.coordinate.latitude)!, (locationManager.location?.coordinate.longitude)!)
//        
//        let pinForUserLocation = MGLPointAnnotation()
//        
//        pinForUserLocation.coordinate = userLocationCoordinates
//        
//        pinForUserLocation.title = ""
//        pinForUserLocation.subtitle = ""
//        
//        mapView.addAnnotation(pinForUserLocation)
//        mapView.showAnnotations([pinForUserLocation], animated: true)
//        
//        //When the user clicks the button, send the CLLocation Coordinate 2D make to firebase against their user ID
//        
//        let uid = FIRAuth.auth()!.currentUser!.uid
//        
//        let locationsRef = FIRDatabase.database().reference().child("users").child(uid).child("personalLocations").childByAutoId()
//        
//        locationsRef.setValue(["lat": locationManager.location?.coordinate.latitude, "lng": locationManager.location?.coordinate.longitude, "name": "Test", "type": 0, "subtitle": "some subtitle"])
//        
//        
//
//    }
    
    
    
  
    //Show the annotation callout

    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    
        return true
    

    }
    
    //Hide the callout view
    
    func mapView(_ mapView: MGLMapView, annotation: MGLAnnotation, calloutAccessoryControlTapped control: UIControl) {
        
        if control.tag == 100 {
            guard let annotation = annotation as? SkateAnnotation else { return }
            
            
            self.performSegue(withIdentifier: "EditSaveSpotSegue", sender: annotation.id)
            
            

            
        } else if control.tag == 101 {
            
         //   self.performSegue(withIdentifier: "InviteUserSegue", sender: view)
            
            
            guard let skateAnnotation = annotation as? SkateAnnotation else { return }
            
            mapDirections(for: skateAnnotation.skatepark)
    
            
            
        }
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditSaveSpotSegue" {
            let destination = segue.destination as! EditSaveSpotViewController
            destination.parkId = sender as! String
        }
    }
    

    
    func mapView(_ mapView: MGLMapView, rightCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        
        guard let skateAnnotation = annotation as? SkateAnnotation else { return nil }
       
        if skateAnnotation.canEdit {
            
            let button = UIButton(type: .contactAdd)
            button.tag = 100
            return button
        }
        
        return nil
        
        
    }
    

    //Information button - turn this into 360 image
    
    func mapView(_ mapView: MGLMapView, leftCalloutAccessoryViewFor annotation: MGLAnnotation) -> UIView? {
        
        
        
        let button = UIButton(type: .detailDisclosure)
        button.tag = 101
        return button 
        

    }
    
    
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        
        
        
        if let annotation = annotation as? SkateAnnotation {
            
            self.performSegue(withIdentifier: "SkateImageSegue", sender: annotation.id)
            
            print("YourAnnotation: \(annotation.photoUrl)")
            
        }
    }
        
        
    

    //Image for Annotation - Change this for Skatepark/StreetSkating
    
     func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        
        
        
        

//     //   return nil
      
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: marker!)
        
        if annotationImage == nil {
            
           // var image = UIImage(named: "SkateAnnotation1")!
            
            
            var image = UIImage(named: marker!)
            
            image = image?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: (image?.size.height)! / 2, right: 0))
            
            annotationImage = MGLAnnotationImage(image: image!, reuseIdentifier: marker!)
            
            
            
        }
        
        return annotationImage
        
    }
    
}





