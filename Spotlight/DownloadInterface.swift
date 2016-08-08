//
//  DownloadInterface.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-06.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Firebase
import Photos
import CoreLocation

protocol DownloadInterfaceProtocol {
    func downloadPhotoKeysNear(lat: CLLocationDegrees, lon: CLLocationDegrees, completed: (photoInfoKeys: [PhotoInfoKey]?, err: ErrorType?) -> ())
    func downloadPhoto(photoInfoKey: PhotoInfoKey, completed: (photo: Photo?, err: ErrorType?) -> ())
    
    //func getPhotoKeysNearMe() -> [PhotoInfoKey]
    //func getMyPhotoKeys() -> [PhotoInfoKey]
}

extension ModelInterface: DownloadInterfaceProtocol {
    func downloadPhotoKeysNear(lat: CLLocationDegrees, lon: CLLocationDegrees, completed: (photoInfoKeys: [PhotoInfoKey]?, err: ErrorType?) -> ()) {
        
        Location.sharedInstance.downloadGeoBlockKeysFromNeighbouringBigGeoBlocks(lat, lon: lon) { (geoBlockKeys, err) in
            guard err == nil else {
                Log.debug("could not download geo block keys in big geo block neighbours")
                completed(photoInfoKeys: nil, err: err)
                return
            }
            
            let sortedGeoBlockKeys = Location.sharedInstance.sortGeoBlocksByDistance(geoBlockKeys!, lat: lat, lon: lon)
            
            Location.sharedInstance.downloadPhotoInfoKeysInGeoBlocks(sortedGeoBlockKeys, completed: { (photoInfoKeys, err) in
                guard err == nil else {
                    Log.debug("could not download photo keys in geoblocks")
                    completed(photoInfoKeys: nil, err: err)
                    return
                }
                
                completed(photoInfoKeys: photoInfoKeys, err: nil)
            })
        }
    }
    
    func downloadPhoto(photoInfoKey: PhotoInfoKey, completed: (photo: Photo?, err: ErrorType?) -> ()) {
        downloadPhotoInfo(photoInfoKey) { (photoInfo, err) in
            guard err == nil else {
                Log.debug("couldn't get PhotoInfo")
                completed(photo: nil, err: err)
                return
            }
            
            Log.info("downloaded photo info for: \(photoInfo!.name)")
            
            self.downloadImage(photoInfo!, completed: { (image, err) in
                guard err == nil else {
                    Log.debug("couldn't get image")
                    completed(photo: nil, err: err)
                    return
                }
                
                Log.info("downloaded image: \(photoInfo!.name)")
                
                let photo = Photo(image: image!)
                photo.photoInfo = photoInfo
                
                Log.info("image of width: \(image!.size.width)")
                
                completed(photo: photo, err: nil)
            })
        }
    }
    
    private func downloadPhotoInfo(photoInfoKey: PhotoInfoKey, completed:(photoInfo: PhotoInfo?, err: ErrorType?) -> ()) {
        
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.child(PermanentConstants.realTimeDatabasePhotoInfo).child(photoInfoKey).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            // Get photo info values
            let userKey = snapshot.value![PermanentConstants.photoInfoUserKey] as! String
            let lat = snapshot.value![PermanentConstants.photoInfoLat] as! CLLocationDegrees
            let lon = snapshot.value![PermanentConstants.photoInfoLon] as! CLLocationDegrees
            let time = snapshot.value![PermanentConstants.photoInfoTimeStamp] as! String
            
            let photoInfo = PhotoInfo(userKey: userKey, photoInfoKey: photoInfoKey, lat: lat, lon: lon, timeStamp: time)
            
            completed(photoInfo: photoInfo, err: nil)
            
        }) { (error) in
            Log.debug(error.localizedDescription)
            completed(photoInfo: nil, err: error)
        }
    }
    
    private func downloadImage(photoInfo: PhotoInfo, completed: (image: UIImage?, err: ErrorType?) -> ()) {
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL(FirebaseConstants.storageURL)
        
        // Create a reference to the file you want to download
        let imageRef = storageRef.child(photoInfo.onlineStoragePath)
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imageRef.dataWithMaxSize(FirebaseConstants.maxDownloadByteSize) { (data, error) -> Void in
            guard error == nil else {
                Log.debug("download image:\(photoInfo.name) failed")
                completed(image: nil, err: error)
                return
            }
            
            let downloadedImage: UIImage! = UIImage(data: data!)
            completed(image: downloadedImage, err: nil)
        }
    }
}
