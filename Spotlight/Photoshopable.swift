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
    func resizeImage(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / photoImage.size.width
        let newHeight = photoImage.size.height * scale
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        photoImage.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /// Resizes an image to the maximum constant width (length in horizontal) keeping its original proportions
    func resizeImage() {
        resizeImage(Constants.compressedImageWidth)
    }
}


