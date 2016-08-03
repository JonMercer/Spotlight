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
    var lat: CLLocationDegrees = 0
    var lon: CLLocationDegrees = 0

}

//MARK: - Locatable
extension Location: Locatable {
    
}

//MARK: - Locatable
extension Location: GeoBlockable {
    
}
//MARK: - CLLocationManagerDelegate
extension Location: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lat = (locations.first?.coordinate.latitude)!
        lon = (locations.first?.coordinate.longitude)!
        
    }
    
    /// Log any errors to the console.
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error occured: \(error.localizedDescription).")
    }
}