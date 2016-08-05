//
//  Photo.swift
//  Spotlight
//
//  Created by Odin on 2016-07-31.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//
import Foundation
import Photos

/// The everything needed to represent a photo the user created
/// - Attention: this class is tighly coupled with UploadInterface. 
/// - Todo: consider creating a protocol to uphold a contract. SL-172
class Photo {
    var photoInfo: PhotoInfo?
    var photoImage: UIImage
    
    init(image: UIImage) {
        photoImage = image
    }
}