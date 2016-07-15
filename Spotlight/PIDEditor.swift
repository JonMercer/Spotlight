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

struct PIDEntry {
    var pid: PID
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees
    var photoName: String
}

protocol PIDEditor {

    func savePIDEntry(pidEntry: PIDEntry) -> PID
    func editLat(pid: PID, lat: CLLocationDegrees)
    func editLon(pid: PID, lon: CLLocationDegrees)
    func editPhotoName(name: String)
}

extension PIDEditor {

    //TODO: SL-93
    func savePIDEntry(pidEntry: PIDEntry) -> PID {
        let firebaseRef = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let key = firebaseRef.child("PIDs").childByAutoId().key
        
        let PID = ["uid": userID!,
                   "name": pidEntry.photoName,
                   "lat": pidEntry.lat,
                   "lon": pidEntry.lon]
        
        let childUpdates = ["/PIDs/\(key)": PID,
                            "/UIDs/\(userID!)/PIDs/\(key)/": PID]
        
        // Consider using completionhandler for knowing success
        firebaseRef.updateChildValues(childUpdates)
        
        return key
    }
    
    func editLat(pid: PID, lat: CLLocationDegrees) {
        //TODO:add implementations
        Log.error("Called a dummy PODEditor")
    }
    func editLon(pid: PID, lon: CLLocationDegrees) {
        //TODO:add implementations
        Log.error("Called a dummy PODEditor")

    }
    func editPhotoName(name: String) {
        //TODO:add implementations
        Log.error("Called a dummy PODEditor")
    }
}