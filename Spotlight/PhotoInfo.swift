//
//  PhotoInfo.swift
//  Spotlight
//
//  Created by Odin on 2016-07-31.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation

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