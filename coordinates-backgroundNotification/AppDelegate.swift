//
//  AppDelegate.swift
//  coordinates-backgroundNotification
//
//  Created by Yu Hong Huang on 2017-10-04.
//  Copyright © 2017 Yu Hong Huang. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        
        UNUserNotificationCenter.current().delegate = self
        
    
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
            if error == nil {
                if success == true {
                    print("Permission granted")
                    notificationCenter.removeAllDeliveredNotifications()
                }
                else {
                    print("Permission denied")
                }
            } else {
                print(error!)
            }
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate: CLLocationManagerDelegate {
    
    
    
    func handleEvent(forRegion region: CLRegion!) {
        
        print("Geofence triggered!")
        
        // Show an alert if application is active
        if UIApplication.shared.applicationState == .active {
                let message = region.identifier
                window?.rootViewController?.showAlert(withTitle: nil, message: message)
        } else {
            
            
            // Otherwise present a local notification
            let notification = UILocalNotification()
            notification.alertBody = region.identifier
            notification.soundName = "Default"
            UIApplication.shared.presentLocalNotificationNow(notification)
            
            // Otherwise present a local notification
            // Swift
//        let center = UNUserNotificationCenter.current()
//            let content = UNMutableNotificationContent()
//            content.title = "Enter region"
//            content.body = region.identifier
//            content.sound = UNNotificationSound.default()
//
//
//
//            let trigger = UNLocationNotificationTrigger(region:region, repeats:false)
//
//            let identifier = "enteringRegionNotification"
//            let request = UNNotificationRequest(identifier: identifier,
//                                                content: content, trigger: trigger)
//
//            center.add(request, withCompletionHandler: { (error) in
//                if let error = error {
//                    print(error)
//                }
//            })
            
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            handleEvent(forRegion: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            handleEvent(forRegion: region)
        }
    }
}

// MARK: Helper Extensions
extension UIViewController {
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
