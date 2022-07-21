//
//  findShopLocationsController.swift
//  esteeLauderChallenge
//
//  Created by Alex Markova on 7/19/22.
//


import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class findShopLocationsController : UIViewController, CLLocationManagerDelegate {
    
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self // could take some time for info to come back; this is used to handle responses asymchronously
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // gives more explicit value for map location
        locationManager.requestWhenInUseAuthorization() // triggers location permission dialog
        locationManager.requestLocation() // triggers a 1-time location request
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable

//        let searchBar = resultSearchController!.searchBar
//        searchBar.sizeToFit()
//        searchBar.placeholder = "Estee Lauder"
//        navigationItem.titleView = resultSearchController?.searchBar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "test"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false // doesn't hide nav bar when results are shown
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView // passes along a handle of mapView from the main view controller onto locationSearchTable

        locationSearchTable.handleMapSearchDelegate = self
    }
    
    @objc func getDirections(){
        // convert the cached selectedPin to a MKMapItem. The Map Item is then able to open up driving directions in Apple Maps using the openInMapsWithLaunchOptions(j) method.
        guard let selectedPin = selectedPin else { return }
        let mapItem = MKMapItem(placemark: selectedPin)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)

        print ("GET DIRECTION")
        print("\n\n\nI DON'T THINKEWIFHEWO")
//        if let selectedPin = selectedPin {
//            let mapItem = MKMapItem(placemark: selectedPin)
//            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
//            mapItem.openInMaps(launchOptions: launchOptions)
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
        print(locations)
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // defines zoom level
            let region = MKCoordinateRegion(center: location.coordinate, span: span) // defines map center
            mapView.setRegion(region, animated: true) // defines map region (combining previous steps)
        }
    }
}
extension findShopLocationsController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations) // clears map of any existing annotations
        let annotation = MKPointAnnotation() // contains a coordinate, title, and subtitle
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation) // adds above annotation to map
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true) // specifies zoom level
        }
}

extension findShopLocationsController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MKUserLocation { // MKUserLocation is a map annotation that appears as blue pulsing dot
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
//        let smallSquare = CGSize(width: 30, height: 30)
//        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: .zero, size: smallSquare))
        print("\n\n\nHELLLOOOOO\n\n\n")
        button.setBackgroundImage(UIImage(named: "car"), for: [])
//        button.setBackgroundImage(UIImage(named: "car"), for: [])
//        button.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        button.addTarget(self, action: #selector(findShopLocationsController.getDirections), for: .touchUpInside)

        
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
