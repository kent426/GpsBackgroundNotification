//
//  Region.swift
//  coordinates-backgroundNotification
//
//  Created by Yu Hong Huang on 2017-10-04.
//  Copyright © 2017 Yu Hong Huang. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Pin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String? {
        return identifier
    }
    var subtitle: String?
    var notificationText: String?
    var radius: CLLocationDistance = 200
    var identifier: String
    
    var region :CLCircularRegion {
        return CLCircularRegion(center: coordinate, radius: self.radius, identifier: self.identifier)
    }
    
    init(coordinate: CLLocationCoordinate2D, identifier: String, subtitle: String?, notificationText: String?) {
        self.coordinate = coordinate
        self.identifier = identifier
        self.subtitle = subtitle
        self.notificationText = notificationText
    }
    
}
