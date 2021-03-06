//
//  SkateAnnotation.swift
//  Skate Demo
//
//  Created by Callum Carmichael (i7726422) on 16/05/2017.
//  Copyright © 2017 Callum Carmichael (i7726422). All rights reserved.
//

import Foundation
import Mapbox


class SkateAnnotation: MGLPointAnnotation {
    
    var canEdit = false
    var id: String!
    var type: SkateType!
    var skatepark: Skatepark!
    var photoUrl: String?
    
    var image: UIImage?
    
}
    

