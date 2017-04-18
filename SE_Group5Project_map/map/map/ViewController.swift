//
//  ViewController.swift
//  map
//
//  Created by Randolph Hunter Smith on 4/11/17.
//  Copyright © 2017 Randolph Hunter Smith. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    class CityLocation: NSObject, MKAnnotation {
        var title: String?
        var coordinate: CLLocationCoordinate2D
        
        
        init(title: String, coordinate: CLLocationCoordinate2D) {
            self.title = title
            self.coordinate = coordinate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
        let newYork=CityLocation(title: "New York City", coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude:-74.0059))
        let newOrleans = CityLocation(title: "New Orleans", coordinate: CLLocationCoordinate2D(latitude: 29.9511, longitude: -90.0715))
        let atlanta = CityLocation(title: "Atlanta", coordinate: CLLocationCoordinate2D(latitude: 33.7490, longitude: -84.3880))
        let sanFransico = CityLocation(title: "San Fransico", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
        let chicago = CityLocation(title: "Chicago", coordinate: CLLocationCoordinate2D(latitude:41.8781, longitude:-87.6298))
        
        mapView.addAnnotation(newYork)
        mapView.addAnnotation(newOrleans)
        mapView.addAnnotation(atlanta)
        mapView.addAnnotation(sanFransico)
        mapView.addAnnotation(chicago)
        
        mapView.addAnnotations([newYork, newOrleans, atlanta, sanFransico, chicago])
       
         }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    

    
    
    @IBAction func locateMe(sender: UIBarButtonItem) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.2,0.2)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        let name = "Employee"
        let job = "Job 1"
        
        myAnnotation.title = name + " " + job
        mapView.addAnnotation(myAnnotation)
        
    }
}
