//
//  Region.swift
//  coordinates-backgroundNotification
//
//  Created by Yu Hong Huang on 2017-10-04.
//  Copyright © 2017 Yu Hong Huang. All rights reserved.
//

import Foundation
import CoreLocation

class Region {
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier : String
    
    init(_ coordinate:CLLocationCoordinate2D , _ radius: CLLocationDistance, _ identifier: String) {
        self.coordinate = coordinate
        self.radius = radius
        self.identifier = identifier
    }
    
    func getCLCircularRegion() {
        
    }
    
}
