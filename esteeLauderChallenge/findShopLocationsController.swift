//
//  findShopLocationsController.swift
//  esteeLauderChallenge
//
//  Created by Alex Markova on 7/19/22.
//


import UIKit
import MapKit

class findShopLocationsController : UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self // could take some time for info to come back; this is used to handle responses asymchronously
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // gives more explicit value for map location
        locationManager.requestWhenInUseAuthorization() // triggers location permission dialog
        locationManager.requestLocation() // triggers a 1-time location request
    }
}

extension findShopLocationsController{ //  : CLLocationManagerDelegate (if added, shows error for redundant conformance)
//     code taken from here: https://stackoverflow.com/questions/40345170/delegate-must-respond-to-locationmanagerdidupdatelocations-swift-eroor
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//
//        if locations.first != nil {
//            print("location:: \(locations)")
//        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print("UM RUNNING")
            if let location = locations.first {
                print("INWOEIWEHFEWOIH")
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // defines zoom level
                let region = MKCoordinateRegion(center: location.coordinate, span: span) // defines map center
                mapView.setRegion(region, animated: true) // defines map region (combining previous steps)
            }
        }

    }
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        // func called when user responds to permission dialog
//        if status == .authorizedWhenInUse { // happens when user says allow
//            locationManager.requestLocation()
//        }
//    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
////        if let location = locations.first {
////            print("location:: \(location)")
////        }
//        if locations.first != nil {
//            print("location:: (location)")
//        }
//    }

//    func locationManager(manager: CLLocationManager, didFailWithError error: Error) {
//        print("error:: \(error.localizedDescription)")
//    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
