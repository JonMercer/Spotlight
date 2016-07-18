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
    var photoID: PhotoID = "#####################"
    var lat: CLLocationDegrees = 99999999.99
    var lon: CLLocationDegrees = 99999999.99
    var photoName: String = "####################"
    
    func debugDescription() -> String {
        return "photoID: \(photoID), lat: \(lat.description), lon: \(lon.description), photoName: \(photoName)"
    }
    
    //TODO: SL-99
    func getPhotoID() -> PhotoID {
        return photoID
    }
    
    func getLat(photoID: PhotoID) -> CLLocationDegrees {
        return lat
    }
    
    func getLon(photoID: PhotoID) -> CLLocationDegrees {
        return lon
    }
    
    func getPhotoName() -> String {
        return photoName
    }
}

protocol PhotoEntityEditor {

    func createPhotoEntity(name: ImageName) -> PhotoEntity
    func savePhotoEntity(photoEntity: PhotoEntity) -> PhotoID
    func editLat(photoID: PhotoID, lat: CLLocationDegrees)
    func editLon(photoID: PhotoID, lon: CLLocationDegrees)
    func editPhotoName(name: String)
    func getPhotoEntity (photoID: PhotoID, completion: (photoEntity: PhotoEntity) -> Void)
}

extension PhotoEntityEditor {
    
    func createPhotoEntity(name: ImageName) -> PhotoEntity {
        let firebaseRef = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let key = firebaseRef.child("PhotoEntities").childByAutoId().key
        
        let photoEntity = PhotoEntity(photoID: key,
                                lat: LocationManager.sharedInstance.getCurrentLat(),
                                lon: LocationManager.sharedInstance.getCurrentLon(),
                                photoName: name)
        let PhotoID = ["userID": userID!,
                   "name": photoEntity.photoName,
                   "lat": photoEntity.lat,
                   "lon": photoEntity.lon]
        
        let childUpdates = ["/PhotoEntities/\(key)": PhotoID,
                            "/UserEntities/\(userID!)/PhotoEntities/\(key)/": PhotoID]
        
        // Consider using completionhandler for knowing success
        firebaseRef.updateChildValues(childUpdates)
        
        return photoEntity
    }

    //TODO: SL-93
    func savePhotoEntity(photoEntity: PhotoEntity) -> PhotoID {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")
        return "shouldn't be called"
    }
    
    func editLat(photoID: PhotoID, lat: CLLocationDegrees) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")
    }
    func editLon(photoID: PhotoID, lon: CLLocationDegrees) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")

    }
    func editPhotoName(name: String) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")
    }

    func getPhotoEntity (photoID: PhotoID, completion: (photoEntity: PhotoEntity) -> Void) {
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.child("PhotoEntities").child(photoID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get photo entity values
            let name = snapshot.value!["name"] as! String
            let lat = snapshot.value!["lat"] as! CLLocationDegrees
            let lon = snapshot.value!["lon"] as! CLLocationDegrees
            
            
            let photo = PhotoEntity(photoID: photoID, lat: lat, lon: lon, photoName: name)
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