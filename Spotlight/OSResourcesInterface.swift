//
//  OSResourcesInterface.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-06.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation
import Photos

protocol OSResourcesInterfaceProtocol {
    func savePhotoLocally(photo: Photo, completed: (err: ErrorType) -> ())
    func getLocation() -> (lat: CLLocationDegrees, lon: CLLocationDegrees)
    func getCurrentTime()
}

extension ModelInterface: OSResourcesInterfaceProtocol {
    func savePhotoLocally(photo: Photo, completed: (err: ErrorType) -> ()) {
        let compressedImage = self.resizeImage(photo.photoImage, newWidth: CGFloat(Constants.compressedImageWidth))
   
        // Convert PhotoView.image into a JPEG representation with full resolution
        let imageJPEG = UIImageJPEGRepresentation(compressedImage, 1.0)!
        let imageData = NSData(data: imageJPEG)
        
        //TODO: simplify
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
        
        let dateString = NSDate().fireBaseImageTimeStamp()
        
        //TODO: check if each image has a brand new file path
        let filePath = (documentsDirectory as NSString).stringByAppendingPathComponent(dateString + ".jpg")
        let success = imageData.writeToFile(filePath, atomically: true)
        
        if !success {
            completed(err: ResourceError.FailedSavePhotoLocally)
        }
    }
    
    func getLocation() -> (lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let lat = Location.sharedInstance.currentLat;
        let lon = Location.sharedInstance.currentLon;
        
        return (lat: lat, lon: lon)
    }
    
    func getCurrentTime() {
        
    }
    
    private func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}