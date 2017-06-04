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

/// Contains most of the functionality for hardware related actions
/// - Attention: Does not handle location nor time
/// - Todo: Add collecting phone numbers and refactor last few functions
protocol OSResourcesInterfaceProtocol {
    func savePhotoLocally(photo: Photo, completed: (err: ErrorType) -> ())
}

extension ModelInterface: OSResourcesInterfaceProtocol {
    func savePhotoLocally(photoToSave: Photo, completed: (err: ErrorType) -> ()) {
        var photo = photoToSave
        photo.resizePhotoImage()
   
        // Convert PhotoView.image into a JPEG representation with full resolution
        let imageJPEG = UIImageJPEGRepresentation(photo.photoImage, 1.0)!
        let imageData = NSData(data: imageJPEG)
        
        //TODO: simplify (try logging this to figure out)
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
        
        let dateString = NSDate().fireBaseImageTimeStamp()
        
        //TODO: check if each image has a brand new file path
        let filePath = (documentsDirectory as NSString).stringByAppendingPathComponent(dateString + ".jpg")
        let success = imageData.writeToFile(filePath, atomically: true)
        
        if !success {
            completed(err: ResourceError.FailedSavePhotoLocally)
        }
    }
    
    
    
    
    //MARK: - TODO: refactor below
    func loadLocalImage(path: FilePath) -> UIImage {
        // The file is stored in the app's file system.  Now retrieve it and convert it back to an image.
        
        //TODO use constant?
        let dir = NSURL(fileURLWithPath: path)
        let retrievedData = NSData(contentsOfURL: dir)
        return UIImage(data:retrievedData!)!
    }
    
    func loadLocalImageByName(fileName: String) -> UIImage {
        let filePath = (FilePathConstants.directoryStringPath as NSString).stringByAppendingPathComponent(fileName+".jpg")
        return self.loadLocalImage(filePath)
    }
    
    func getImageURLsInDirectory() -> [NSURL] {
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try NSFileManager.defaultManager().contentsOfDirectoryAtURL( FilePathConstants.directoryURLPath, includingPropertiesForKeys: nil, options: [])
            //            print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            let jpgFiles = directoryContents.filter{ $0.pathExtension == "jpg" }
            //print("image(jpg) urls:",jpgFiles)
            
            return jpgFiles;
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        //TODO: fix this. It should return something meaningful or throw an error
        return [NSURL()]
    }
    
    func getImageNamesInDirectory() -> [String] {
        return self.getImageURLsInDirectory().flatMap({$0.URLByDeletingPathExtension?.lastPathComponent})
    }
    
}