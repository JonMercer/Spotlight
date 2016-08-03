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
    /// Uploads a photo to online storage.
    /// - Requires: the user must be signed in
    /// - Postcondition: completion returns error or nil
    func uploadPhoto(photo: Photo, completed: (err: ErrorType?) -> ())
    func uploadPhotoInfo(photo: Photo, completed: (err: ErrorType?) -> ())
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
        guard photo.photoInfo?.onlineStoragePath != nil else {
            Log.error("photo info you tried to upload has no storage name/path")
            completed(err: UploadError.FailedUploadPhotoInfo)
            return
        }
        
        Log.debug("about to upload: \(photo.photoInfo?.onlineStoragePath)")
        
        let firebaseRef = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let photoKey = firebaseRef.child(PermanentConstants.realTimeDatabasePhotoInfo).childByAutoId().key
        let imageTimeStamp = NSDate().fireBaseImageTimeStamp()
        
        
        
        
        //Refactor below...
        let lat = LocationManager.sharedInstance.getCurrentLat()
        let lon = LocationManager.sharedInstance.getCurrentLon()
        let geoBlockKey = GeoUtil.getGeoBlockKeyByCurrentLatLon()
        let bigGeoBlockKey: String = GeoUtil.getBigGeoBlockKeyByCurrentLatLon()
        
        let photoEntity = PhotoEntity(photoID: photoKey,
                                      lat: lat,
                                      lon: lon,
                                      photoName: (photo.photoInfo?.onlineStoragePath)!,
                                      timeStamp: imageTimeStamp)
        
        let photoEntityToUpload = ["userID": userID!,
                                   "name": photoEntity.photoName,
                                   "lat": photoEntity.lat,
                                   "lon": photoEntity.lon,
                                   "latBlock": LocationManager.sharedInstance.getLocationBlock(photoEntity.lat),
                                   "lonBlock": LocationManager.sharedInstance.getLocationBlock(photoEntity.lon),
                                   "timeStamp": photoEntity.timeStamp]
        
        let childUpdates = ["/PhotoEntities/\(photoKey)": photoEntityToUpload,
                            "/UserEntities/\(userID!)/PhotoEntities/\(photoKey)/": photoEntityToUpload,
                            "/BigGeoBlock/\(bigGeoBlockKey)/\(geoBlockKey)": 1,
                            "/GeoBlock/\(geoBlockKey)/\(photoKey)": photoEntity.timeStamp]
        
        firebaseRef.updateChildValues(childUpdates, withCompletionBlock: {(error,ref) in
            if(error != nil) {
                Log.error("Could not update image metadata of image:\(photo.photoInfo?.name)")
            } else {
                //TODO: return photo
                //completed(photoEntity: photoEntity)
            }
        })
        
        
    }
}

