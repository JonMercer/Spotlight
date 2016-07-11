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
    func downloadPhoto(foo: StorageURL) -> UIImage {
        return UIImage()
    }
    
}