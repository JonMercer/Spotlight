//
//  Photo.swift
//  Spotlight
//
//  Created by Odin on 2016-07-31.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//
import Foundation
import Photos

// MARK: - PhotoProtocol
protocol PhotoProtocol {
    var photoInfo: PhotoInfo? { get set }
    var photoImage: UIImage { get set }
    var photoIcon: UIImage { get set }
}

/// The everything needed to represent a photo the user created
/// - Attention: this class is tighly coupled with UploadInterface.
/// - Todo: consider creating a protocol to uphold a contract. SL-172
class Photo: PhotoProtocol {
    var photoInfo: PhotoInfo?
    var photoImage: UIImage
    var photoIcon: UIImage
    
    // TODO: SL-203
    init(image: UIImage) {
        photoImage = image
        photoIcon = image
    }
}


// MARK: - Photoshopable
extension Photo: Photoshopable {
    
}