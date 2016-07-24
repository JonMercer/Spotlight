//
//  PhotoEntityEditor.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-07-13.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase

struct PhotoEntity {
    var photoID: PhotoEntityKey = "#####################"
    var lat: CLLocationDegrees = 99999999.99
    var lon: CLLocationDegrees = 99999999.99
    var photoName: String = "####################"
    var timeStamp: String = "1111-11-11 11:11:11"
    
    func debugDescription() -> String {
        return "photoID: \(photoID), lat: \(lat.description), lon: \(lon.description), photoName: \(photoName), timeStamp: \(timeStamp)"
    }
    
    //TODO: SL-99
    func getPhotoID() -> PhotoEntityKey {
        return photoID
    }
    
    func getLat(photoID: PhotoEntityKey) -> CLLocationDegrees {
        return lat
    }
    
    func getLon(photoID: PhotoEntityKey) -> CLLocationDegrees {
        return lon
    }
    
    func getPhotoName() -> String {
        return photoName
    }
    
    func getTimeStamp() -> String {
        return timeStamp
    }
}

protocol PhotoEntityEditor {
    
    func createPhotoEntity(name: ImageName, completion: (photoEntity: PhotoEntity) -> Void)
    func savePhotoEntity(photoEntity: PhotoEntity) -> PhotoEntityKey
    func editLat(photoID: PhotoEntityKey, lat: CLLocationDegrees)
    func editLon(photoID: PhotoEntityKey, lon: CLLocationDegrees)
    func editPhotoName(name: String)
    func getPhotoEntity (photoID: PhotoEntityKey, completion: (photoEntity: PhotoEntity) -> Void)
}

extension PhotoEntityEditor {
    
    func createPhotoEntity(name: ImageName, completion: (photoEntity: PhotoEntity) -> Void) {
        //SL-118
        let firebaseRef = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let photoKey = firebaseRef.child("PhotoEntities").childByAutoId().key
        
        let imageTimeStamp = NSDate().fireBaseImageTimeStamp()
        let lat = LocationManager.sharedInstance.getCurrentLat()
        let lon = LocationManager.sharedInstance.getCurrentLon()
        let geoBlockLatKey: String = LocationManager.sharedInstance.getLocationBlockKey(lat)
        let geoBlockLonKey: String = LocationManager.sharedInstance.getLocationBlockKey(lon)
        let bigGeoBlockLatKey: String = LocationManager.sharedInstance.getBigGeoBlockKey(lat)
        let bigGeoBlockLonKey: String = LocationManager.sharedInstance.getBigGeoBlockKey(lon)
        
        let photoEntity = PhotoEntity(photoID: photoKey,
                                      lat: lat,
                                      lon: lon,
                                      photoName: name,
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
                            "/BigGeoBlock/\(bigGeoBlockLatKey)_\(bigGeoBlockLonKey)/\(geoBlockLatKey)_\(geoBlockLonKey)": 1,
                            "/GeoBlock/\(geoBlockLatKey)_\(geoBlockLonKey)/\(photoKey)": photoEntity.timeStamp]
        
        firebaseRef.updateChildValues(childUpdates, withCompletionBlock: {(error,ref) in
            if(error != nil) {
                Log.error("Could not update image metadata of image:\(name)")
            } else {
                completion(photoEntity: photoEntity)
            }
        })
    }
    
    //TODO: SL-93
    func savePhotoEntity(photoEntity: PhotoEntity) -> PhotoEntityKey {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")
        return "shouldn't be called"
    }
    
    func editLat(photoID: PhotoEntityKey, lat: CLLocationDegrees) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")
    }
    func editLon(photoID: PhotoEntityKey, lon: CLLocationDegrees) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")
        
    }
    func editPhotoName(name: String) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")
    }
    
    func getPhotoEntity(photoID: PhotoEntityKey, completion: (photoEntity: PhotoEntity) -> Void) {
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.child("PhotoEntities").child(photoID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get photo entity values
            let name = snapshot.value!["name"] as! String
            let lat = snapshot.value!["lat"] as! CLLocationDegrees
            let lon = snapshot.value!["lon"] as! CLLocationDegrees
            let time = snapshot.value!["timeStamp"] as! String
            
            
            let photo = PhotoEntity(photoID: photoID, lat: lat, lon: lon, photoName: name, timeStamp: time)
            completion(photoEntity: photo)
            
        }) { (error) in
            Log.error(error.localizedDescription)
        }
    }
    
    func testCompletion(completion: (result: String) -> Void){
        // I wanted to wait 5 seconds here, but it doesn't seem so simple to implement it.  No need to do it for now.
        completion(result: "test")
    }
}