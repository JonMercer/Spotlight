//
//  Location.swift
//  Spotlight
//
//  Created by Odin on 2016-08-02.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation

class Location: NSObject {
    //TODO: don't hardcode 0,0
    var currentLat: CLLocationDegrees = 0.0
    var currentLon: CLLocationDegrees = 0.0
    var locManager = CLLocationManager()
    static let sharedInstance = Location()
    
    override init() {
        super.init()
        locManager.delegate = self
        locManager.requestWhenInUseAuthorization()
    }
}

//MARK: - Locatable
extension Location: Locatable {
    
}

//MARK: - GeoBlockable
extension Location: GeoBlockable {
    
}
//MARK: - CLLocationManagerDelegate
extension Location: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLat = (locations.first?.coordinate.latitude)!
        currentLon = (locations.first?.coordinate.longitude)!
    }
    
    /// Log any errors to the console.
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        Log.error("Location error:\(error.localizedDescription).")
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