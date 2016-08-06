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
    
    func downloadPhotoByName(name: ImageName, completionHandler: (err: ErrorType, image: UIImage) -> ()) {
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL(FirebaseConstants.storageURL)
        
        // Create a reference to the file you want to download
        let islandRef = storageRef.child("images/\(name)")
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.dataWithMaxSize(7 * 1024 * 1024) { (data, error) -> Void in
            if (error != nil) {
                Log.error("download image:\(name) failed")
            } else {
                // Data for "images/island.jpg" is returned
                let downloadedImage: UIImage! = UIImage(data: data!)
                
                completionHandler(err: StorageError.FailedDownload, image: downloadedImage)
            }
        }
    }
    
}