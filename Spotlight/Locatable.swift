//
//  Locatable.swift
//  Spotlight
//
//  Created by Odin on 2016-08-02.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation

protocol Locatable {
    var lat: CLLocationDegrees { get }
    var lon: CLLocationDegrees { get }
    
    func getCurrentLat() -> CLLocationDegrees
    func getCurrentLon() -> CLLocationDegrees
}

extension Locatable {
    func getCurrentLat() -> CLLocationDegrees {
        return 42.0
    }
    func getCurrentLon() -> CLLocationDegrees {
        return 42.0
    }
}

extension Locatable where Self: GeoBlockable {
    func getGeoBlockKey() -> GeoBlockKey {
        return getGeoBlockKey(getCurrentLat(), lon: getCurrentLon())
    }
    func getBigGeoBlockKey() -> BigGeoBlockKey {
        return getBigGeoBlockKey(getCurrentLat(), lon: getCurrentLon())
    }
}
