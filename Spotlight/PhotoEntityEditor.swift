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
    var pid: PID
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees
    var photoName: String
}

protocol PhotoEntityEditor {

    func createPhotoEntity(name: ImageName) -> PhotoEntity
    func savePhotoEntity(photoEntity: PhotoEntity) -> PID
    func editLat(pid: PID, lat: CLLocationDegrees)
    func editLon(pid: PID, lon: CLLocationDegrees)
    func editPhotoName(name: String)
}

extension PhotoEntityEditor {
    
    func createPhotoEntity(name: ImageName) -> PhotoEntity {
        let firebaseRef = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let key = firebaseRef.child("PhotoEntities").childByAutoId().key
        
        let photoEntity = PhotoEntity(pid: key,
                                lat: LocationManager.sharedInstance.getCurrentLat(),
                                lon: LocationManager.sharedInstance.getCurrentLon(),
                                photoName: name)
        let PID = ["uid": userID!,
                   "name": photoEntity.photoName,
                   "lat": photoEntity.lat,
                   "lon": photoEntity.lon]
        
        let childUpdates = ["/PhotoEntities/\(key)": PID,
                            "/UIDs/\(userID!)/PhotoEntities/\(key)/": PID]
        
        // Consider using completionhandler for knowing success
        firebaseRef.updateChildValues(childUpdates)
        
        return photoEntity
    }

    //TODO: SL-93
    func savePhotoEntity(photoEntity: PhotoEntity) -> PID {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")
        return "shouldn't be called"
    }
    
    func editLat(pid: PID, lat: CLLocationDegrees) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")
    }
    func editLon(pid: PID, lon: CLLocationDegrees) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")

    }
    func editPhotoName(name: String) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntityEditor")
    }
}