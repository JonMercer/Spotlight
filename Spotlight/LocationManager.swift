//
//  LocationManager.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-07-13.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation

/// DEPRECATE
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
    
    // PURPOSE: We wanted to split up the world in 0.005 (lat lon) increments.
    //          ex: So 1.12345 = 1.12000
    //                 1.23879 = 1.23500
    //                 -1.12345 = -1.12500
    //                 -1.23879 = -1.24000
    func getLocationBlock(loc: CLLocationDegrees) -> CLLocationDegrees {
        //SL-114
        Log.warn("Make sure that the value from this call is rounded on the receiving end")
        if(loc >= 0) {
            let blockEdge = (loc % 0.01) * 1000
            if(blockEdge < 5) {
                return ((floor(loc * 100) * 10) + 0) / 1000
            } else {
                return ((floor(loc * 100) * 10) + 5) / 1000
            }
        } else {
            let positiveLoc = loc * -1
            let blockEdge = (positiveLoc % 0.01) * 1000
            if(blockEdge < 5) {
                return ((((floor(positiveLoc * 100) * 10) + 0) / 1000) + 0.005) * -1
            } else {
                return ((((floor(positiveLoc * 100) * 10) + 5) / 1000) + 0.005) * -1
            }
        }
    }
    
    //SL-114
    func getLocationBlockKey(loc: CLLocationDegrees) -> String {
        // Needed to multiply by 1000 because keys cannot contain '.'
        let roundedLoc = Int(round(getLocationBlock(loc) * 1000))
        if roundedLoc < 0 {
            return String(format: "%07d", roundedLoc)
        } else {
            return String(format: "%06d", roundedLoc)
        }
    }
    
    func getBigGeoBlockKey(loc: CLLocationDegrees) -> String {
        let roundedLoc = Int(floor(getLocationBlock(loc)))
        if roundedLoc < 0 {
            return String(format: "%04d", roundedLoc)
        } else {
            return String(format: "%03d", roundedLoc)
        }
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