//
//  DetailsViewController.swift
//  Yelp
//
//  Created by Eli Scherrer on 1/24/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit


class DetailsViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager : CLLocationManager!
    
    var business: Business? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the focus and add a pin for the resturant
        let centerLocation = CLLocation(latitude: (business?.latitude)!, longitude: (business?.longitude)!)
        goToLocation(location: centerLocation)
        let pinLocation = CLLocationCoordinate2DMake((business?.latitude)!, (business?.longitude)!)
        addAnnotationAtCoordinate(coordinate: pinLocation)

        //
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //focus the map on the location
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.01, 0.01)
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
    
    //keep track of user location
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }

}
