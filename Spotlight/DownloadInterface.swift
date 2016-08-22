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
    func downloadPhotoIcon(photoInfoKey: PhotoInfoKey, completed: (photo: Photo?, err: ErrorType?) -> ())
    
    /// Downloads the current user's PhotoInfoKeys
    /// - Parameter userKey: the user's key to grab their photos from
    /// - Parameter completed photoInfoKeys: a list of photoInfoKeys
    func downloadUserPhotoInfoKeys(userKey: UserKey, completed: (photoInfoKeys: [PhotoInfoKey]?, err: ErrorType?) -> ())
    
    func downloadPhoto(byPhotoInfoKey: PhotoInfoKey, completed: (photo: Photo?, err: ErrorType?) -> ())
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
    
    func downloadPhotoIcon(photoInfoKey: PhotoInfoKey, completed: (photo: Photo?, err: ErrorType?) -> ()) {
        downloadPhotoInfo(photoInfoKey) { (photoInfo, err) in
            guard err == nil else {
                Log.debug("couldn't get PhotoInfo")
                completed(photo: nil, err: err)
                return
            }
            
            Log.info("downloaded photo info for: \(photoInfo!.name)")
            
            self.downloadIcons(photoInfo!, completed: { (image, err) in
                guard err == nil else {
                    Log.debug("couldn't get image")
                    completed(photo: nil, err: err)
                    return
                }
                
                Log.info("downloaded image: \(photoInfo!.name)")
                
                //TODO: SL-203
                let photo = Photo(image: image!)
                photo.photoInfo = photoInfo
                
                Log.info("image of width: \(image!.size.width)")
                
                completed(photo: photo, err: nil)
            })
        }
    }
    
    func downloadUserPhotoInfoKeys(userKey: UserKey, completed: (photoInfoKeys: [PhotoInfoKey]?, err: ErrorType?) -> ()) {
        let firebaseRef = FIRDatabase.database().reference()
        
        //check if user has uploaded photos
        firebaseRef.child(PermanentConstants.realTimeDatabaseUserInfo).observeSingleEventOfType(.Value, withBlock: {
            (snapshot) in
            if(!snapshot.hasChild(userKey)) {
                // user hasn't uploaded any photos so return an empty list
                completed(photoInfoKeys: [], err: nil)
            }
        })
        
        
        firebaseRef.child(PermanentConstants.realTimeDatabaseUserInfo).child(userKey).child(PermanentConstants.realTimeDatabasePhotoInfo).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var listOfKeys = [PhotoInfoKey]()
            for child in snapshot.children {
                listOfKeys.append(child.key)
            }
            
            if !listOfKeys.isEmpty {
                completed(photoInfoKeys: listOfKeys.reverse(), err: nil)
            } else {
                Log.debug("List of children should not be empty")
                completed(photoInfoKeys: nil, err: DownloadError.UserHasNoPhotos)
            }
            
        }) { (error) in
            completed(photoInfoKeys: nil, err: DownloadError.FailedDownloadUserPhotoInfoKeys)
        }

    }
    
    func downloadPhoto(byPhotoInfoKey: PhotoInfoKey, completed: (photo: Photo?, err: ErrorType?) -> ()) {
        downloadPhotoInfo(byPhotoInfoKey) { (photoInfo, err) in
            guard err == nil || photoInfo != nil else {
                completed(photo: nil, err: err)
                return;
            }
            
            self.downloadBigImage(photoInfo!, completed: { (image, err) in
                guard err == nil || image != nil else {
                    completed(photo: nil, err: err)
                    return;
                }
                
                //SL-209
                let photo = Photo(image: image!)
                photo.photoInfo = photoInfo
                completed(photo: photo, err: err)
            })
            
        }
    }
    
    
    //MARK: - Private Helper Functions
    
    private func downloadPhotoInfo(photoInfoKey: PhotoInfoKey, completed:(photoInfo: PhotoInfo?, err: ErrorType?) -> ()) {
        
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.child(PermanentConstants.realTimeDatabasePhotoInfo).child(photoInfoKey).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            // Get photo info values
            let userKey = snapshot.value![PermanentConstants.photoInfoUserKey] as! String
            let lat = snapshot.value![PermanentConstants.photoInfoLat] as! CLLocationDegrees
            let lon = snapshot.value![PermanentConstants.photoInfoLon] as! CLLocationDegrees
            let time = snapshot.value![PermanentConstants.photoInfoTimeStamp] as! String
            let description = snapshot.value![PermanentConstants.photoInfoDescription] as! String
            
            var photoInfo = PhotoInfo(userKey: userKey, photoInfoKey: photoInfoKey, lat: lat, lon: lon, timeStamp: time)
            
            
            photoInfo.description = description
            
            
            completed(photoInfo: photoInfo, err: nil)
            
        }) { (error) in
            Log.debug(error.localizedDescription)
            completed(photoInfo: nil, err: error)
        }
    }
    
    private func downloadIcons(photoInfo: PhotoInfo, completed: (image: UIImage?, err: ErrorType?) -> ()) {
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL(FirebaseConstants.storageURL)
        
        // Create a reference to the file you want to download
        let imageRef = storageRef.child(photoInfo.onlineIconStoragePath)
        
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
    
    private func downloadBigImage(photoInfo: PhotoInfo, completed: (image: UIImage?, err: ErrorType?) -> ()) {
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
