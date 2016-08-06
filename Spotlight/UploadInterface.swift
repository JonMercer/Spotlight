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

/// Everything needed to upload to the database and storage. This includes key generation.
/// - Attention: this class is tightly linked to Photo and PhotoInfo classes
protocol UploadInterfaceProtocol {
    /// Uploads a photo to online storage.
    /// - Requires: the user must be signed in
    /// - Parameter photo: A photo object with the image and the name of the image to upload
    /// - Parameter completed err: an error uploading to storage
    func uploadPhoto(photo: Photo, completed: (err: ErrorType?) -> ())
    
    /// Uploads a photo to realtime database.
    /// - Requires: the user must be signed in
    /// - Parameter photo: A photo object with the image and PhotoInfo
    /// - Parameter completed err: an error uploading to database
    func uploadPhotoInfo(photo: Photo, completed: (err: ErrorType?) -> ())
    
    /// Generates a new photo info.
    /// This is here so that we can get firebase related stuff like keys
    /// - Returns: PhotoInfo with names, keys, timestamp, lat, and lon
    func createPhotoInfo() -> PhotoInfo
}

extension ModelInterface: UploadInterfaceProtocol {
    func uploadPhoto(photo: Photo, completed: (err: ErrorType?) -> ()) {
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL(FirebaseConstants.storageURL)
        
        if let onlinePath = photo.photoInfo?.onlineStoragePath {
            let photoRef = storageRef.child(onlinePath)
            let imageData = UIImageJPEGRepresentation(photo.photoImage, 0.1)
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            //INFO: https://firebase.google.com/docs/reference/ios/firebasestorage/interface_f_i_r_storage_upload_task
            // we should consider using uploadTask to pause and resume upload
            photoRef.putData(imageData!, metadata: metaData) { metadata, error in
                if (error != nil) {
                    Log.error("\(onlinePath) failed to upload!")
                    completed(err: UploadError.FailedUploadPhoto)
                } else {
                    Log.info("uploaded an image: \(onlinePath)")
                    completed(err: nil)
                }
            }
        } else {
            completed(err: UploadError.FailedUploadPhoto)
        }
    }
    
    func uploadPhotoInfo(photo: Photo, completed: (err: ErrorType?) -> ()) {
        guard photo.photoInfo != nil else {
            //TODO: SL-167
            Log.error("photo info you tried to upload has photoPath")
            completed(err: UploadError.FailedUploadPhotoInfo)
            return
        }
        
        Log.debug("about to upload: \(photo.photoInfo!.onlineStoragePath)")
        
        let firebaseRef = FIRDatabase.database().reference()
        
        
        let geoBlockKey = Location.sharedInstance.getGeoBlockKey()
        let bigGeoBlockKey = Location.sharedInstance.getBigGeoBlockKey()
        
        let photoInfoToUpload = ["userID": photo.photoInfo!.userKey,
                                 "name": photo.photoInfo!.name,
                                 "lat": photo.photoInfo!.lat,
                                 "lon": photo.photoInfo!.lon,
                                 "timeStamp": photo.photoInfo!.timeStamp]
        
        //SL-171
        let photoInfoAddress = "/\(PermanentConstants.realTimeDatabasePhotoInfo)/\(photo.photoInfo!.key)"
        let userInfoAddress = "/\(PermanentConstants.realTimeDatabaseUserInfo)/\(photo.photoInfo!.userKey)/\(PermanentConstants.realTimeDatabasePhotoInfo)/\(photo.photoInfo!.key)/"
        let bigGeoBlockAddress = "/\(PermanentConstants.realTimeDatabaseBigGeoBlock)/\(bigGeoBlockKey)/\(geoBlockKey)"
        let geoBlockAddress = "/\(PermanentConstants.realTimeDatabaseGeoBlock)/\(geoBlockKey)/\(photo.photoInfo!.key)"
        
        let childUpdates = [photoInfoAddress: photoInfoToUpload,
                            userInfoAddress: 1,
                            bigGeoBlockAddress: 1,
                            geoBlockAddress: (photo.photoInfo?.timeStamp)!]
        
        firebaseRef.updateChildValues(childUpdates, withCompletionBlock: {(error,ref) in
            if(error != nil) {
                //TODO: SL-167
                Log.error("Could not update image metadata of image:\(photo.photoInfo?.name)")
                completed(err: UploadError.FailedUploadPhotoInfo)
            } else {
                //TODO: return photo
                //completed(photo: photo)
            }
        })
    }
    
    func createPhotoInfo() -> PhotoInfo {
        let firebaseRef = FIRDatabase.database().reference()
        let photoInfoKey = firebaseRef.child(PermanentConstants.realTimeDatabasePhotoInfo).childByAutoId().key
        let userKey = FIRAuth.auth()?.currentUser?.uid
        
        return PhotoInfo(userKey: userKey!, photoInfoKey: photoInfoKey, lat: Location.sharedInstance.currentLat, lon: Location.sharedInstance.currentLat, timeStamp: NSDate().fireBaseImageTimeStamp())
    }
}

