//
//  Skatepark.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 22/03/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import Foundation
import FirebaseDatabase
import CoreLocation


enum SkateType: Int {
    case park = 0, street, own
    
    func getString() -> String {
        switch self {
        case .own:
            return "Favourite Spots"
        case .street:
            return "Street Skating"
        case .park:
            return "Skatepark"
        default:
            return "Street Skating"
        }
    }
    
}



class Skatepark {
    
    let coordinate: CLLocationCoordinate2D!
    var name: String!
    var subtitle: String!
    var type: SkateType
    var editable: Bool!
    var id: String!
    var did: String?
    var ref: FIRDatabaseReference?
    var photoUrl: String?
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as! [String: Any]
        
        id = snapshot.key
        did = snapshotValue["did"] as? String
        ref = snapshot.ref
        name = snapshotValue["name"] as! String
        subtitle = snapshotValue["subtitle"] as! String
        coordinate = CLLocationCoordinate2D(latitude: snapshotValue["lat"] as! Double, longitude: snapshotValue["lng"] as! Double)
        type = SkateType(rawValue: snapshotValue["type"] as! Int)!
        editable = snapshotValue["editable"] as! Bool
        photoUrl = snapshotValue["photoUrl"] as? String
        
    
    }
    

    func dictionaryValues() -> [String: Any] {
        
        var data = [String: Any]()
        
        data = [
            "lat": coordinate.latitude,
            "lng": coordinate.longitude,
            "name": name,
            "subtitle": subtitle,
            "type": type.rawValue,
            "editable": editable,
            "id": id,
            "did": id
        ]
        
        return data
        
    }

}



