//
//  Locatable.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-07-13.
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