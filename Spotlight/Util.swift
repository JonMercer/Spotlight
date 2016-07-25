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
}

extension NSDate {
    
    func hour() -> Int {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    
    func minute() -> Int {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    
    func timeStamp() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter.stringFromDate(self)
    }
    
    func fireBaseImageTimeStamp() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.stringFromDate(self)
    }
}

