//
//  Constants.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-06-26.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation

typealias FilePath = String

enum Constants {
    static let albumName = "Spotlight"
    static let tempPathName = "test_path"  // temporary path name for testing local storage
}

enum FilePathConstants {
    static let directoryStringPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
    
    static let directoryURLPath = NSURL(fileURLWithPath: directoryStringPath)
}