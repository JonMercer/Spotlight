//
//  FirebaseStorage.swift
//  Spotlight
//
//  Created by Odin on 2016-07-10.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Photos
import Firebase

extension ModelInterface: Storable {
    
    func uploadPhoto(url: LocalURL, completionHandler: (err: ErrorType) -> ()) {
        //"{(signedIn) in" is the same as "completionHandler: {(signedIn) in"
        ModelInterface.sharedInstance.isUserSignedIn({(signedIn) in
            if(!signedIn) {
                //TODO: handle this
            }
            let storage = FIRStorage.storage()
            let storageRef = storage.referenceForURL(FirebaseConstants.storageURL)
            
            let photoRef = storageRef.child("images/\(url.lastPathComponent!)")
            
            let uploadTask = photoRef.putFile(url, metadata: nil) { metadata, error in
                if (error != nil) {
                    print("ERROR \(NSDate().timeStamp()): Uploading image:\(url.lastPathComponent!) failed")
                    completionHandler(err: StorageError.FailedUpload)
                } else {
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    
                    //TODO:save this URL into FIR database
                    let downloadURL = metadata!.downloadURL
                    
                    print("DEBUG \(NSDate().timeStamp()): Image:\(url.lastPathComponent!) uploaded.")
                }
            }
        })
    }
    
    func downloadPhoto(url: StorageURL, completionHandler: (err: ErrorType, image: UIImage) -> ()) {
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL(FirebaseConstants.storageURL)
        
        let imageName = "2016-07-21-21-41-27.jpg"
        
        // Create a reference to the file you want to download
        let islandRef = storageRef.child("images/\(imageName)")
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.dataWithMaxSize(7 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                Log.error("download image:\(imageName) failed")
            } else {
                // Data for "images/island.jpg" is returned
                let downloadedImage: UIImage! = UIImage(data: data!)
                
                completionHandler(err: StorageError.FailedDownload, image: downloadedImage)
            }
        }
    }
    
}