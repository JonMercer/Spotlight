//
//  Photo.swift
//  Spotlight
//
//  Created by Odin on 2016-07-31.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Photos


class Photo {
    var photoInfo: PhotoInfo?
    var photoImage: UIImage
    
    init(image: UIImage, lat: CLLocationDegrees, lon: CLLocationDegrees, timeStamp: TimeStampString) {
        photoImage = image
        photoInfo = PhotoInfo(lat: lat, lon: lon, timeStamp: timeStamp)
    }
}