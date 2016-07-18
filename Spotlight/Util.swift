//
//  Util.swift
//  Spotlight
//
//  Created by Odin on 2016-07-10.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation

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
}

