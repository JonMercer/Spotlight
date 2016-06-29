//
//  LocalStoragePhotoManager.swift
//  Spotlight
//
//  Created by Odin on 2016-06-28.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Photos

class LocalStoragePhotoManager {
    
    static func saveImageLocal(image: UIImage) -> FilePath {
        // Convert PhotoView.image into a JPEG representation
        let imageJPEG = UIImageJPEGRepresentation(image, 1.0)!
        let data = NSData(data: imageJPEG)
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
        
//        var formatter = NSDateFormatter()
//        formatter.dateFormat = "HH-mm-ss"
//        var dateString = formatter.stringFromDate(NSDate())
        
        let fileName = Constants.tempPathName // temporary file name for testing.  change this later.
        //TODO: check if each image has a brand new file path
        let filePath = (documentsDirectory as NSString).stringByAppendingPathComponent(fileName)
        let success = data.writeToFile(filePath, atomically: true)
        if !success { print ("Got some error writing to a file!!") }
        return filePath
    }
    
    
    static func loadLocalImage(path: FilePath) -> UIImage {
        // The file is stored in the app's file system.  Now retrieve it and convert it back to an image.
        let dir = NSURL(fileURLWithPath: path)
        let retrievedData = NSData(contentsOfURL: dir)
        return UIImage(data:retrievedData!)!
    }
}