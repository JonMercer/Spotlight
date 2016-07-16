//
//  PIDEditor.swift
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

    func createPIDEntry(name: ImageName) -> PhotoEntity
    func savePIDEntry(pidEntry: PhotoEntity) -> PID
    func editLat(pid: PID, lat: CLLocationDegrees)
    func editLon(pid: PID, lon: CLLocationDegrees)
    func editPhotoName(name: String)
}

extension PhotoEntityEditor {
    
    func createPhotoEntity(name: ImageName) -> PhotoEntity {
        let firebaseRef = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let key = firebaseRef.child("PhotoEntities").childByAutoId().key
        
        let pidEntry = PhotoEntity(pid: key,
                                   lat: LocationManager.sharedInstance.getCurrentLat(),
                                   lon: LocationManager.sharedInstance.getCurrentLon(),
                                   photoName: name)
        let PID = ["uid": userID!,
                   "name": pidEntry.photoName,
                   "lat": pidEntry.lat,
                   "lon": pidEntry.lon]
        
        let childUpdates = ["/PhotoEntities/\(key)": PID,
                            "/UserEntities/\(userID!)/PhotoEntities/\(key)/": PID]
        
        // Consider using completionhandler for knowing success
        firebaseRef.updateChildValues(childUpdates)
        
        return pidEntry
    }

    //TODO: SL-93
    func savePhotoEntity(pidEntry: PhotoEntity) -> PID {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntities")
        return "shouldn't be called"
    }
    
    func editLat(pid: PID, lat: CLLocationDegrees) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntities")
    }
    func editLon(pid: PID, lon: CLLocationDegrees) {
        //TODO:add implementations
        Log.error("Called a dummy PhotoEntities")

    }
    func editPhotoName(name: String) {
        //TODO:add implementations
        Log.error("Called a dummy PODEditor")
    }
}