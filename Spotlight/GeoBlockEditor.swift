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
    func getPhotoKeysInGeoBlocks(listOfGeoBlocks: [GeoBlockKey], completion: (listOfPhotoEntities: [PhotoEntityKey]) -> ())
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
    
    func getPhotoKeysInGeoBlocks(listOfGeoBlocks: [GeoBlockKey], completion: (listOfPhotoEntities: [PhotoEntityKey]) -> ()) {
        var listOfPhotoEntitiesToReturn = [PhotoEntityKey]()

        // to handle async calls
        var counter: Int = 0;
        for geoBlockKey in listOfGeoBlocks {
            getKeysInGeoBlock(geoBlockKey, completion: { (listOfPhotoEntities) in
                listOfPhotoEntitiesToReturn.appendContentsOf(listOfPhotoEntities)
                counter = counter + 1
                
                if(counter == listOfGeoBlocks.count) {
                    completion(listOfPhotoEntities: listOfPhotoEntitiesToReturn)
                }
            })
        }
    }

}