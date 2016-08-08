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


extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}

extension String {
    static func locationToString(loc: String) -> String{
        return loc.stringByReplacingOccurrencesOfString(".", withString: "_")
    }
}

