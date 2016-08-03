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
    func getGeoBlock(loc: CLLocationDegrees) -> CLLocationIntegers
}

extension GeoBlockable {
    func getGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> GeoBlockKey {
        return "fff"
    }
    func getBigGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> BigGeoBlockKey {
        return "fff"
    }
    
    // PURPOSE: We wanted to split up the world in 0.005 (lat lon) increments.
    //          ex: So 1.12345 = 1.12000
    //                 1.23879 = 1.23500
    //                 -1.12345 = -1.12500
    //                 -1.23879 = -1.24000
    func getGeoBlock(loc: CLLocationDegrees) -> CLLocationIntegers {
        //did not want to work with doubles because -4.5 is technically -4.50000000001
        var locInt = Int(loc * 1000)
        
        if (locInt % 5) == 0 {
            return locInt
        }
        
        let lastDigit = (locInt % 10)
        
    
        let fourthDigit = abs(Int(loc * 10000) % 10)
        
        if locInt > 0 {
            if lastDigit >= 0 && lastDigit < 5 {
                return locInt - lastDigit
            } else {
                return locInt - lastDigit + 5
            }
        } else {
            if lastDigit < 0 && lastDigit > -5 {
                return locInt - lastDigit - 5
            } else {
                return locInt - lastDigit - 10
            }
            
//            locInt = abs(locInt)
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        //SL-114
//        Log.warn("Make sure that the value from this call is rounded on the receiving end")
//        if(loc >= 0) {
//            let blockEdge = (loc % 0.01) * 1000
//            if(blockEdge < 5) {
//                return ((floor(loc * 100) * 10) + 0) / 1000
//            } else {
//                return ((floor(loc * 100) * 10) + 5) / 1000
//            }
//        } else {
//            let positiveLoc = loc * -1
//            let blockEdge = (positiveLoc % 0.01) * 1000
//            if(blockEdge < 5) {
//                return ((((floor(positiveLoc * 100) * 10) + 0) / 1000) + 0.005) * -1
//            } else {
//                return ((((floor(positiveLoc * 100) * 10) + 5) / 1000) + 0.005) * -1
//            }
//        }
    }
}