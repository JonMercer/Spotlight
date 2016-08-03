//
//  GeoBlockable.swift
//  Spotlight
//
//  Created by Odin on 2016-08-02.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation

protocol GeoBlockable {
    func getGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> GeoBlockKey
    func getBigGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> BigGeoBlockKey
}

extension GeoBlockable {
    func getGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> GeoBlockKey {
        return "fff"
    }
    func getBigGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> BigGeoBlockKey {
        return "fff"
    }
}