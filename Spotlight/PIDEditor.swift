//
//  PIDEditor.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-07-13.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import CoreLocation

struct PIDEntry {
    var pid: PID
    var lat: CLLocationManager
    var lon: CLLocationManager
    var photoName: String
}

protocol PIDEditor {

    func createNewPIDEntry() -> PID
    func savePIDEntry(pidEntry: PIDEntry) -> PID
    func editLat(pid: PID, lat: CLLocationDegrees)
    func editLon(pid: PID, lon: CLLocationDegrees)
    func editPhotoName(name: String)
}

extension PIDEditor {
    
    func createNewPIDEntry() -> PID {
        //TODO:add implementations
        Log.error("Called a dummy PODEditor")
        return "you should not be seeing this"
    }
    
    func savePIDEntry(pidEntry: PIDEntry) -> PID {
        //TODO:add implementations
        Log.error("Called a dummy PODEditor")
        return "you should not be seeing this"
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