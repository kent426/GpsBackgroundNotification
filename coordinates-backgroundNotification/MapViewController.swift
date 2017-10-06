//
//  ViewController.swift
//  coordinates-backgroundNotification
//
//  Created by Yu Hong Huang on 2017-10-04.
//  Copyright © 2017 Yu Hong Huang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapview: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        let applePin = Pin(coordinate: CLLocationCoordinate2DMake(37.331695,-122.0322801), identifier: "Apple",subtitle: nil, notificationText: "Enter Apple!!")
        
        startMonitoring(applePin.region)
        
        
        
        
        mapview.addAnnotation(applePin);
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//map delegate funcs
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedAlways) {
            mapview.showsUserLocation = true
            print("authorized")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region with identifier: \(region!.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with the following error: \(error)")
    }
    
    func startMonitoring(_ region : CLCircularRegion) {
        
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            print("Geofencing is not supported on this device!")
            return
        }
        
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            print("Your geotification is saved but will only be activated once you grant Geotify permission to access the device location.")
        }
        
        //for entry
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        locationManager.startMonitoring(for: region)
        
    }
    
    func stopMonitoring(_ region : CLCircularRegion) {
        for existingRegion in locationManager.monitoredRegions {
            if(existingRegion.identifier == region.identifier) {
                locationManager.stopMonitoring(for: region)
            }
        }
        locationManager.stopMonitoring(for: region)
        
    }
}

