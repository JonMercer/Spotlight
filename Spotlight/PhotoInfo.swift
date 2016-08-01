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
    var key: PhotoInfoKey
    var name: ImageName?
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees
    var timeStamp: String
    var onlineStoragePath: OnlineStoragePath?
    
    init(key: PhotoInfoKey, lat: CLLocationDegrees, lon: CLLocationDegrees, timeStamp: String) {
        self.key = key
        self.lat = lat
        self.lon = lon
        self.timeStamp = timeStamp
        self.name = generateName()
        self.onlineStoragePath = generateOnlineStoragePath()
    }
    
    private func generateName() -> String{
        return "\(timeStamp)-\(String.locationToString(lat.description))-\(String.locationToString(lon.description))"
    }
    
    private func generateOnlineStoragePath() -> String {
        if self.name == nil {
            Log.error("photo name should never be nil")
        }
        return "\(PermanentConstants.onlineStoragePhotoFolder)\(self.name!).jpg"
    }
}

protocol PhotoInfoEditable {
    var photoInfo: PhotoInfo? { get set }
    
    func createPhotoInfo()
}