//
//  LocationManager.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-07-13.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, Locatable {
    var lat: CLLocationDegrees = 0.0
    var lon: CLLocationDegrees = 0.0
    let locManager = CLLocationManager()
    
    //TODO: will this die?
    static let sharedInstance = LocationManager()
    
    func customInit() {
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLat() -> CLLocationDegrees {
        return lat
    }
    
    func getCurrentLon() -> CLLocationDegrees {
        return lon
    }
    
    func startGettingLoc() {
        locManager.allowsBackgroundLocationUpdates = true
        locManager.startUpdatingLocation()
    }
    
    func stopGettingLoc() {
        locManager.allowsBackgroundLocationUpdates = false
        locManager.stopUpdatingLocation()
    }
}


//MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lat = (locations.first?.coordinate.latitude)!
        lon = (locations.first?.coordinate.longitude)!
        
    }
    
    /// Log any errors to the console.
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error occured: \(error.localizedDescription).")
    }
}