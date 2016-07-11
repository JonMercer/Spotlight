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
    
//    var listOfFiles...
    static func saveImageLocal(image: UIImage) -> FilePath {
        // Convert PhotoView.image into a JPEG representation
        let imageJPEG = UIImageJPEGRepresentation(image, 1.0)!
        let data = NSData(data: imageJPEG)
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "HH-mm-ss"
        var dateString = formatter.stringFromDate(NSDate())
        
        let fileName = Constants.tempPathName // temporary file name for testing.  change this later.
        //TODO: check if each image has a brand new file path
        let filePath = (documentsDirectory as NSString).stringByAppendingPathComponent(dateString+".jpg")
        let success = data.writeToFile(filePath, atomically: true)
        if !success { print ("Got some error writing to a file!!") }
        return filePath
    }
    
    
    static func loadLocalImage(path: FilePath) -> UIImage {
        // The file is stored in the app's file system.  Now retrieve it and convert it back to an image.
        
        //TODO use constant?
        let dir = NSURL(fileURLWithPath: path)
        let retrievedData = NSData(contentsOfURL: dir)
        return UIImage(data:retrievedData!)!
    }
    
    static func loadLocalImageByName(fileName: String) -> UIImage {
        let filePath = (FilePathConstants.directoryStringPath as NSString).stringByAppendingPathComponent(fileName+".jpg")
        return self.loadLocalImage(filePath)
    }
    
    static func getImageURLsInDirectory() -> [NSURL] {
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
    
    static func getImageNamesInDirectory() -> [String] {
        return self.getImageURLsInDirectory().flatMap({$0.URLByDeletingPathExtension?.lastPathComponent})
    }
}