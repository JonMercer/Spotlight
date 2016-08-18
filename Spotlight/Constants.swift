//
//  Constants.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-06-26.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Photos

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
    
    //TODO: SL-202
    static let compressedImageWidth = CGFloat(100)
    static let compressedIconImageWidth = CGFloat(20)
    
    static let AdmobID = "ca-app-pub-5958828933999537/7928373101"
    static let zoomLevel: Float = 15.0
    static let imageCompressionRatio = CGFloat(0.1) // JPEG quality between 0 and 1
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

enum ResourceError: ErrorType {
    case FailedSavePhotoLocally
}

enum DownloadError: ErrorType {
    case FailedDownloadPhoto
    case FailedDownloadPhotoInfo
    case FailedDownloadPhotoImage
    case FailedDownloadPhotoInfoKeys
    case EmptyGeoBlock
    case EmptyGeoBlockRadius
    case UserHasNoPhotos
    case FailedDownloadUserPhotoInfoKeys
}

enum Segues {
    static let toSingleMap = "segueToSingleMap"
    static let toGridView = "segueToGridView"
    static let toTabView = "segueToTabView"
}

//MARK: = UIConstants
enum UIConstants {
    static let description = "Add description here"
}

// MARK: - Changeable backend information
enum FirebaseConstants {
    static let storageURL = "gs://spotlight-5a0c3.appspot.com"
    static let emailDomain = "@spotlight.com"
    static let maxDownloadByteSize: Int64 = 7 * 1024 * 1024 // 7 MB
}

// MARK: - Constants that should not be changed
enum PermanentConstants {
    static let onlineStoragePhotoFolder = "images/"
    static let onlineStoragePhotoIconFolder = "icons/"
    static let realTimeDatabasePhotoInfo = "PhotoInfo"
    static let realTimeDatabaseUserInfo = "UserInfo"
    static let realTimeDatabaseBigGeoBlock = "BigGeoBlock"
    static let realTimeDatabaseGeoBlock = "GeoBlock"
    
    static let photoInfoUserKey = "userKey"
    static let photoInfoName = "name"
    static let photoInfoLat = "lat"
    static let photoInfoLon = "lon"
    static let photoInfoTimeStamp = "timeStamp"
}


// MARK: - Logging
/**
 A log level of debug will print out all levels above it.
 So a log level of WARN will print out WARN, ERROR, and TEST
 */
enum LogLevel {
    static let lvl = LogLevelChoices.DEBUG
}

enum LogLevelChoices {
    static let DEBUG = 1
    static let INFO = 2
    static let WARN = 3
    static let ERROR = 4
    static let TEST = 5
}