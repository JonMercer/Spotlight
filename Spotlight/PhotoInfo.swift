//
//  PhotoInfo.swift
//  Spotlight
//
//  Created by Odin on 2016-07-31.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation

/// The everything needed to represent a photo's data according to the database.
/// This class should not include photo metadata like shutter speed.
/// - Attention: this class is tighly coupled with UploadInterface. 
/// - Todo: Consider creating a protocol to uphold a contract. SL-172
struct PhotoInfo {
    var userKey: UserKey
    var key: PhotoInfoKey
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees
    var timeStamp: TimeStampString
    let name: String
    let onlineStoragePath: OnlineStoragePath
    
    init(userKey: UserKey, photoInfoKey: PhotoInfoKey, lat: CLLocationDegrees, lon: CLLocationDegrees, timeStamp: TimeStampString) {
        self.lat = lat
        self.lon = lon
        self.timeStamp = timeStamp
        self.key = photoInfoKey
        self.userKey = userKey
        self.name = "\(timeStamp)-\(userKey)-\(key)-\(String.locationToString(lat.description))-\(String.locationToString(lon.description))"
        self.onlineStoragePath = "\(PermanentConstants.onlineStoragePhotoFolder)\(self.name).jpg"
    }
}