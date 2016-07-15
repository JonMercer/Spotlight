//
//  Log.swift
//  Spotlight
//
//  Created by Odin on 2016-07-14.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation

class Log {
    static func error(logMessage: String, classPath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        let fileName = URLUtil.getNameFromStringPath(classPath)
        //TODO: make this generic for WARN, INFO, and DEBUG
        print("ERROR \(NSDate().timeStamp()) in \(fileName):\(functionName):\(lineNumber):: \(logMessage)")
    }
    
    static func warn(logMessage: String, classPath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        let fileName = URLUtil.getNameFromStringPath(classPath)
        //TODO: make this generic for WARN, INFO, and DEBUG
        print("WARN \(NSDate().timeStamp()) in \(fileName):\(functionName):\(lineNumber):: \(logMessage)")
    }
    
    static func info(logMessage: String, classPath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        let fileName = URLUtil.getNameFromStringPath(classPath)
        //TODO: make this generic for WARN, INFO, and DEBUG
        print("INFO \(NSDate().timeStamp()) in \(fileName):\(functionName):\(lineNumber):: \(logMessage)")
    }
    
    static func debug(logMessage: String, classPath: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        let fileName = URLUtil.getNameFromStringPath(classPath)
        //TODO: make this generic for WARN, INFO, and DEBUG
        print("DEBUG \(NSDate().timeStamp()) in \(fileName):\(functionName):\(lineNumber):: \(logMessage)")
    }
    
}