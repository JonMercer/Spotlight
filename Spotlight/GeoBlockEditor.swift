//
//  GeoBlockEditor.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-07-24.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

protocol GeoBlockEditor {
    func getKeysInGeoBlock(geoBlock: GeoBlockKey, completion: (listOfPhotoEntities: [PhotoEntityKey]) -> ())
    func getGeoBlockKeyByCurrentLatLon() -> GeoBlockKey
    func getGeoBlockKeyByLatLon(lat: CLLocationDegrees, lon: CLLocationDegrees) -> GeoBlockKey
}

extension GeoBlockEditor {
    func getKeysInGeoBlock(geoBlock: GeoBlockKey, completion: (listOfPhotoEntities: [PhotoEntityKey]) -> ()){
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.child("GeoBlock").child(geoBlock).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var listOfKeys = [PhotoEntityKey]()
            for child in snapshot.children {
                listOfKeys.append(child.key)
            }
            
            if !listOfKeys.isEmpty {
                completion(listOfPhotoEntities: listOfKeys)
            } else {
                Log.error("List of children is empty")
            }
            
        }) { (error) in
            Log.error(error.localizedDescription)
        }
    }
    
    func getGeoBlockKeyByLatLon(lat: CLLocationDegrees, lon: CLLocationDegrees) -> GeoBlockKey {
        let geoBlockLatKey: String = LocationManager.sharedInstance.getLocationBlockKey(lat)
        let geoBlockLonKey: String = LocationManager.sharedInstance.getLocationBlockKey(lon)
        
        return "\(geoBlockLatKey)_\(geoBlockLonKey)"
    }
    
    func getGeoBlockKeyByCurrentLatLon() -> GeoBlockKey {
        let lat = LocationManager.sharedInstance.getCurrentLat()
        let lon = LocationManager.sharedInstance.getCurrentLon()
        
        return getGeoBlockKeyByLatLon(lat, lon: lon)
    }
}