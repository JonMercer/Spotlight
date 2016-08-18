//
//  Photoshopable.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-07.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Photos

/// Performs "Photoshop-like" functions on images, such as filters, resizing, cropping, and color adjustments
protocol Photoshopable {
    
}

extension Photoshopable {
    
}

extension Photoshopable where Self: PhotoProtocol {
    /// Resizes an image to a certain width (length in horizontal) keeping its original proportions
    mutating func resizePhotoImage() {
        let newWidth = Constants.compressedImageWidth
        let scale = newWidth / photoImage.size.width
        let newHeight = photoImage.size.height * scale
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        photoImage.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        
        photoImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    mutating func resizeIconImage() {
        let newWidth = Constants.compressedIconImageWidth
        let scale = newWidth / photoIcon.size.width
        let newHeight = photoIcon.size.height * scale
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        photoIcon.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        
        photoIcon = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}


