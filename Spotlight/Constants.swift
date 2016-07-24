//
//  Constants.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-06-26.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation

typealias FilePath = String
typealias LocalURL = NSURL
typealias StorageURL = NSURL
typealias ImageName = String
typealias PhotoEntityKey = String

enum Constants {
    static let albumName = "Spotlight"
    static let tempPathName = "test_path"  // temporary path name for testing local storage
    static let keySupposedToBeInFIR = "-KN5f_uUIqsw-mbdkNvL"
    static let compressedImageWidth = 400.0
}

enum FilePathConstants {
    static let directoryStringPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
    static let directoryURLPath = NSURL(fileURLWithPath: directoryStringPath)
}

enum FirebaseConstants {
    static let storageURL = "gs://spotlight-5a0c3.appspot.com"
}

enum StorageError: ErrorType {
    case FailedUpload
    case FailedDownload
}