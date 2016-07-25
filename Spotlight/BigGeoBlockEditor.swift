//
//  BigGeoBlockEditor.swift
//  Spotlight
//
//  Created by Odin on 2016-07-24.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Firebase

protocol BigGeoBlockEditor {
    func getBigGeoBlockContent(bigGeoBlock: BigGeoBlockKey, completion: (listOfGeoBlockKeys: [GeoBlockKey]) -> ())
//    func sortGeoBlocks(listOfGeoBlockKeys: [GeoBlockKey], completion: (sortedListOfGeoBlockKey: [GeoBlockKey])-> ())
}

extension BigGeoBlockEditor {
    func getBigGeoBlockContent(bigGeoBlock: BigGeoBlockKey, completion: (listOfGeoBlockKeys: [GeoBlockKey]) -> ()) {
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.child("BigGeoBlock").child(bigGeoBlock).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var listOfKeys = [PhotoEntityKey]()
            for child in snapshot.children {
                listOfKeys.append(child.key)
            }
            
            if !listOfKeys.isEmpty {
                completion(listOfGeoBlockKeys: listOfKeys)
            } else {
                Log.error("List of children is empty")
            }
            
        }) { (error) in
            Log.error(error.localizedDescription)
        }
    }

    func sortGeoBlocks(listOfGeoBlockKeys: [GeoBlockKey], completion: (sortedListOfGeoBlockKey: [GeoBlockKey])-> ()) {
        
        var geoBlockDictionary = [Int: [GeoBlockKey]]()

        let geoBlockThatYoureInKey = GeoUtil.getGeoBlockKeyByCurrentLatLon()

        //Populate
        for geoBlockKey in listOfGeoBlockKeys {
            let geoBlockRadius = GeoUtil.calculateGeoRadius(GeoUtil.extractGeoBlockKeyLatLon(geoBlockThatYoureInKey),
                                                 b: GeoUtil.extractGeoBlockKeyLatLon(geoBlockKey))
            
            if geoBlockDictionary[geoBlockRadius] == nil {
                geoBlockDictionary[geoBlockRadius] = [GeoBlockKey]()
            }
            
            var listAtGeoBlockRadius = geoBlockDictionary[geoBlockRadius]
            listAtGeoBlockRadius?.append(geoBlockKey)
            
            geoBlockDictionary[geoBlockRadius] = listAtGeoBlockRadius

        }
        
        //Sort
        var sortedGeoBlockRadii = geoBlockDictionary.keys.sort()
        var sortedGeoBlockKeysToReturn = [GeoBlockKey]()
        
        for geoBlockRadius in sortedGeoBlockRadii {
            var geoBlocksWithinRadius = geoBlockDictionary[geoBlockRadius]
            geoBlocksWithinRadius?.sortInPlace()
            if geoBlocksWithinRadius != nil {
                sortedGeoBlockKeysToReturn += geoBlocksWithinRadius!
            } else {
                Log.error("GeoBlockRadius: \(geoBlockRadius) is not supposed to be nil in dictionary")
            }
        }
        
        completion(sortedListOfGeoBlockKey: sortedGeoBlockKeysToReturn)

    }
}