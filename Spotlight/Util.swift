//
//  Util.swift
//  Spotlight
//
//  Created by Odin on 2016-07-10.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation

class URLUtil {
    
    static func getNameFromStringPath(stringPath: String) -> String {
        //URL sees that "+" is a " "
        let spaceReplacedStringPath = stringPath.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let url = NSURL(string: spaceReplacedStringPath)
        return url!.lastPathComponent!
    }
    
    static func getNameFromURL(url: NSURL) -> String {
        return url.lastPathComponent!
    }
}

class GeoUtil {
    static func calculateGeoRadius(a: (Int, Int), b: (Int, Int)) -> Int {
        return max(abs(a.0-b.0), abs(a.1-b.1))
    }
    
    static func getGeoBlockKeyByLatLon(lat: CLLocationDegrees, lon: CLLocationDegrees) -> GeoBlockKey {
        let geoBlockLatKey: String = LocationManager.sharedInstance.getLocationBlockKey(lat)
        let geoBlockLonKey: String = LocationManager.sharedInstance.getLocationBlockKey(lon)
        
        return "\(geoBlockLatKey)_\(geoBlockLonKey)"
    }
    
    
    
    static func getGeoBlockKeyByCurrentLatLon() -> GeoBlockKey {
        let lat = LocationManager.sharedInstance.getCurrentLat()
        let lon = LocationManager.sharedInstance.getCurrentLon()
        
        return getGeoBlockKeyByLatLon(lat, lon: lon)
    }
    
    static func extractGeoBlockKeyLatLon(geoBlockKey: GeoBlockKey) -> (Int, Int) {
        let geoBlocksLocs = geoBlockKey.componentsSeparatedByString("_")
        
        return (Int(geoBlocksLocs[0])!,Int(geoBlocksLocs[1])!)
    }
    
    static func getBigGeoBlockKeyByLatLon(lat: CLLocationDegrees, lon: CLLocationDegrees) -> BigGeoBlockKey {
        let bigGeoBlockLatKey: String = LocationManager.sharedInstance.getBigGeoBlockKey(lat)
        let bigGeoBlockLonKey: String = LocationManager.sharedInstance.getBigGeoBlockKey(lon)
        
        return "\(bigGeoBlockLatKey)_\(bigGeoBlockLonKey)"
    }
    
    static func getBigGeoBlockKeyByCurrentLatLon() -> BigGeoBlockKey {
        let lat = LocationManager.sharedInstance.getCurrentLat()
        let lon = LocationManager.sharedInstance.getCurrentLon()
        
        return getBigGeoBlockKeyByLatLon(lat, lon: lon)
    }
    
    static func getBigGeoBlockKeyByNums(lat: Int, lon: Int) -> BigGeoBlockKey {
        return "\(prependZerosForBigGeoBlock(lat))_\(prependZerosForBigGeoBlock(lon))"
    }
    
    static private func prependZerosForBigGeoBlock(loc: Int) -> String {
        if loc < 0 {
            return String(format: "%04d", loc)
        } else {
            return String(format: "%03d", loc)
        }
    }
    
    static func getNeighbouringBigGeoBlockKeys(bigGeoBlockKey: BigGeoBlockKey) -> [BigGeoBlockKey] {
        let bigGeoBlockLatLon = extractGeoBlockKeyLatLon(bigGeoBlockKey)
        var neighbouringBigGeoBlocks = [BigGeoBlockKey]()
        
        for i in -1...1 {
            for j in -1...1 {
                let lat = bigGeoBlockLatLon.0 + i
                let lon = bigGeoBlockLatLon.1 + j
                
                let bigBlockKey = self.getBigGeoBlockKeyByNums(lat, lon: lon)
                
                neighbouringBigGeoBlocks.append(bigBlockKey)
            }
        }
        
        return neighbouringBigGeoBlocks
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}

