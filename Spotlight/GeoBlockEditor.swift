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

}