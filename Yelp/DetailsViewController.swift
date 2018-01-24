//
//  DetailsViewController.swift
//  Yelp
//
//  Created by Eli Scherrer on 1/24/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class DetailsViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager : CLLocationManager!
    
    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the focus and add a pin for the resturant
        let centerLocation = CLLocation(latitude: (business?.latitude)!, longitude: (business?.longitude)!)
        goToLocation(location: centerLocation)
        let pinLocation = CLLocationCoordinate2DMake((business?.latitude)!, (business?.longitude)!)
        addAnnotationAtCoordinate(coordinate: pinLocation)

        //set up location manager stuff that is supposed to handle the user location stuff
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        //set navigation bar title
        navigationItem.title = business?.name
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //focus the map on the location
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.04, 0.04)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    //add a pin on the location
    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = business?.name
        mapView.addAnnotation(annotation)
    }
    
    //if the user changes preferences, start tracking
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    

}
