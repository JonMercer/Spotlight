//
//  NSDateUtil.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-06.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation

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
        formatter.dateFormat = "yyyy-MM-dd_HH_mm_ss"
        return formatter.stringFromDate(self)
    }
}
