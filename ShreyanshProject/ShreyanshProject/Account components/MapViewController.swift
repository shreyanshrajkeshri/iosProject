//
//  MapViewController.swift
//  ShreyanshProject
//
//  Created by Shreyansh Raj on 18/05/20.
//  Copyright © 2020 Shreyansh Raj. All rights reserved.
//

import UIKit
import GoogleMaps


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    private let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 23.8067, longitude: 83.6979)
//        marker.title = "Ramanuj Ganj"
//        marker.snippet = "Home Town"
//        marker.map = mapView

    }
    

    
}


//MARK: CLLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
        guard status == .authorizedWhenInUse else {
            return
            
        }
        
        locationManager.startUpdatingLocation()
      
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
    }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    guard let location = locations.first else {
      return
    }
      
    mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)

    locationManager.stopUpdatingLocation()
  }
}
