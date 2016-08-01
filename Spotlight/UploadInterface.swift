//
//  UploadInterface.swift
//  Spotlight
//
//  Created by Odin on 2016-07-31.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Photos
import Firebase

protocol UploadInterfaceProtocol {
    /**
     Uploads a photo to online storage.
     - Requires: the user must be signed in
     - Postcondition: completion returns error or nil
     */
    func uploadPhoto(photo: Photo, completed: (err: ErrorType?) -> ())
    func uploadPhotoInfo(photo: Photo, completed: (err: ErrorType?) -> ())
}

extension ModelInterface: UploadInterfaceProtocol {
    func uploadPhoto(photo: Photo, completed: (err: ErrorType?) -> ()) {
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL(FirebaseConstants.storageURL)
        
        if let onlinePath = photo.photoInfo?.onlineStoragePath {
            let photoRef = storageRef.child(onlinePath)
            let imageData = UIImageJPEGRepresentation(photo.photoImage, 1.0)
            
            //INFO: https://firebase.google.com/docs/reference/ios/firebasestorage/interface_f_i_r_storage_upload_task
            // we should consider using uploadTask to pause and resume upload
            photoRef.putData(imageData!, metadata: nil) { metadata, error in
                if (error != nil) {
                    Log.error("\(onlinePath) failed to upload!")
                    completed(err: UploadError.FailedUploadPhoto)
                } else {
                    if metadata!.size <= 2 {
                        Log.error("image was not uploaded properly")
                    }
                    Log.info("uploaded an image: \(onlinePath)")
                    completed(err: nil)
                }
            }
        } else {
            completed(err: UploadError.FailedUploadPhoto)
        }
    }
    
    func uploadPhotoInfo(photo: Photo, completed: (err: ErrorType?) -> ()) {
        //save the info to database
    }
}

