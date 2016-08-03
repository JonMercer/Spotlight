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
    var currentLat: CLLocationDegrees { get set }
    var currentLon: CLLocationDegrees { get set }
}

extension Locatable {
}

extension Locatable where Self: GeoBlockable {
    func getGeoBlockKey() -> GeoBlockKey {
        return getGeoBlockKey(currentLat, lon: currentLon)
    }
    func getBigGeoBlockKey() -> BigGeoBlockKey {
        return getBigGeoBlockKey(currentLat, lon: currentLon)
    }
}
