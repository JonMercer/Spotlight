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
        // Needed to multiply by 1000 because keys cannot contain '.'
        let latString = formatGeoBlockKey(getGeoBlock(lat))
        let lonString = formatGeoBlockKey(getGeoBlock(lon))
        return "\(latString)_\(lonString)"
    }
    
    func getBigGeoBlockKey(lat: CLLocationDegrees, lon: CLLocationDegrees) -> BigGeoBlockKey {
        let bigLatString = formatBigGeoBlockKey(getGeoBlock(lat))
        let bigLonString = formatBigGeoBlockKey(getGeoBlock(lon))
        return "\(bigLatString)_\(bigLonString)"
    }
    
    // PURPOSE: We wanted to split up the world in 0.005 (lat lon) increments.
    //          ex: So 1.12345 = 1.12000
    //                 1.23879 = 1.23500
    //                 -1.12345 = -1.12500
    //                 -1.23879 = -1.24000
    func getGeoBlock(loc: CLLocationDegrees) -> Int {
        //did not want to work with doubles because -4.5 is technically -4.50000000001
        let locInt = Int(loc * 1000)
        
        if (loc % 5) == 0 {
            return locInt
        }
        
        //if the number is close to x.xx5xxx
        if (locInt % 5) == 0 && locInt > 0 {
            return locInt
        }
        
        //if the number is close to -x.xx50000 and -x.xx50001. This is here because of ceiling problems
        if (locInt % 5) == 0 && locInt < 0 && (Double(locInt) - (loc * 1000) < 0.0000001) {
            return locInt
        }
        
        //this is the '#' in 123.45#789
        let lastDigit = (locInt % 10)
        
        //positive numbers are floored such that the last digit is a 0 or a 5
        if loc >= 0 {
            if lastDigit >= 0 && lastDigit < 5 {
                return locInt - lastDigit
            } else {
                return locInt - lastDigit + 5
            }
        }
            //negative numbers are ceilinged such that the last digit is a 0 or a 5
        else {
            //if the number ends in a 5, assume that its not 0.00500000
            if lastDigit <= 0 && lastDigit > -5 {
                return locInt - lastDigit - 5
            } else {
                return locInt - lastDigit - 10
            }
        }
    }
    
    private func formatGeoBlockKey(locInt: CLLocationIntegers) -> String {
        if locInt < 0 {
            return String(format: "%07d", locInt)
        } else {
            return String(format: "%06d", locInt)
        }
    }
    
    private func formatBigGeoBlockKey(locInt: CLLocationIntegers) -> String {
        let roundedLoc = Int(floor(Double(locInt)/1000))
        if roundedLoc < 0 {
            return String(format: "%04d", roundedLoc)
        } else {
            return String(format: "%03d", roundedLoc)
        }
    }
}