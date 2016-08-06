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
typealias PhotoEntityKey = String //DEPRECATE
typealias PhotoInfoKey = String
typealias UserKey = String
typealias GeoBlockKey = String
typealias BigGeoBlockKey = String
typealias OnlineStoragePath = String
typealias CLLocationIntegers = Int //CLLocationDegress x 1000
typealias TimeStampString = String
typealias Username = String

enum Constants {
    static let albumName = "Spotlight"
    static let tempPathName = "test_path"  // temporary path name for testing local storage
    static let keySupposedToBeInFIR = "-KNVFMbkvuWGHrf0HzZE"
    static let compressedImageWidth = 400.0
    static let AdmobID = "ca-app-pub-5958828933999537/7928373101"
    static let zoomLevel: Float = 15.0
}

enum FilePathConstants {
    static let directoryStringPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
    static let directoryURLPath = NSURL(fileURLWithPath: directoryStringPath)
}



enum StorageError: ErrorType {
    case FailedUpload
    case FailedDownload
}

// MARK: - Interface Errors
enum UploadError: ErrorType {
    case FailedUploadPhoto
    case FailedUploadPhotoInfo
}

enum AuthError: ErrorType {
    case FailedSignIn
    case FailedUserCreation
    case FailedSignOut
    case FailedSetUsername
}

enum Segues {
    static let toSingleMap = "segueToSingleMap"
    static let toGridView = "segueToGridView"
    static let toTabView = "segueToTabView"
}

// MARK: - Changeable backend information
enum FirebaseConstants {
    static let storageURL = "gs://spotlight-5a0c3.appspot.com"
    static let emailDomain = "@spotlight.com"
}

// MARK: - Constants that should not be changed
enum PermanentConstants {
    static let onlineStoragePhotoFolder = "images/"
    static let realTimeDatabasePhotoInfo = "PhotoInfo"
    static let realTimeDatabaseUserInfo = "UserInfo"
    static let realTimeDatabaseBigGeoBlock = "BigGeoBlock"
    static let realTimeDatabaseGeoBlock = "GeoBlock"
}

// MARK: - Logging
/**
 A log level of debug will print out all levels above it.
 So a log level of WARN will print out WARN, ERROR, and TEST
 */
enum LogLevel {
    static let lvl = LogLevelChoices.TEST
}

enum LogLevelChoices {
    static let DEBUG = 1
    static let INFO = 2
    static let WARN = 3
    static let ERROR = 4
    static let TEST = 5
}