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
    func sortGeoBlocks(listOfGeoBlockKeys: [GeoBlockKey], currentGeoBlockKey: GeoBlockKey, completion: (sortedListOfGeoBlockKey: [GeoBlockKey])-> ())
    func getNeighbouringBigGeoBlockContent(currentBigGeoBlockKey: BigGeoBlockKey, completion: (listOfGeoBlockKeys: [GeoBlockKey]) -> ())
    
}

extension BigGeoBlockEditor {
    func getBigGeoBlockContent(bigGeoBlock: BigGeoBlockKey, completion: (listOfGeoBlockKeys: [GeoBlockKey]) -> ()) {
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.child("BigGeoBlock").child(bigGeoBlock).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            var listOfKeys = [GeoBlockKey]()
            for child in snapshot.children {
                listOfKeys.append(child.key)
            }
            
            if !listOfKeys.isEmpty {
                completion(listOfGeoBlockKeys: listOfKeys)
            } else {
                Log.error("List of children is empty")
                let emptyList = [GeoBlockKey]()

                completion(listOfGeoBlockKeys: emptyList)
            }
            
        }) { (error) in
            Log.error(error.localizedDescription)
        }
    }

    func sortGeoBlocks(listOfGeoBlockKeys: [GeoBlockKey], currentGeoBlockKey: GeoBlockKey, completion: (sortedListOfGeoBlockKey: [GeoBlockKey])-> ()) {
        
        // [Radius (manhattan distance from the center): list of geoBlocks]
        var geoBlockDictionary = [Int: [GeoBlockKey]]()

        //Populate
        for geoBlockKey in listOfGeoBlockKeys {
            let geoBlockRadius = GeoUtil.calculateGeoRadius(GeoUtil.extractGeoBlockKeyLatLon(currentGeoBlockKey), b: GeoUtil.extractGeoBlockKeyLatLon(geoBlockKey))
            
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
    
    func getNeighbouringBigGeoBlockContent(currentBigGeoBlockKey: BigGeoBlockKey, completion: (listOfGeoBlockKeys: [GeoBlockKey]) -> ()) {
        var geoBlockKeysInNeighbouringBigBlocksToReturn = [GeoBlockKey]()
        
        let neighbouringBigGeoBlocks = GeoUtil.getNeighbouringBigGeoBlockKeys(currentBigGeoBlockKey)
        
        var counter: Int = 0
        for bigGeoBlockKey in neighbouringBigGeoBlocks {
            self.getBigGeoBlockContent(bigGeoBlockKey, completion: { (listOfGeoBlockKeys) in
                geoBlockKeysInNeighbouringBigBlocksToReturn.appendContentsOf(listOfGeoBlockKeys)
                counter = counter + 1
                
                if counter == neighbouringBigGeoBlocks.count {
                    self.sortGeoBlocks(geoBlockKeysInNeighbouringBigBlocksToReturn, currentGeoBlockKey: currentBigGeoBlockKey) { (sortedListOfGeoBlockKey) in
                        completion(listOfGeoBlockKeys: sortedListOfGeoBlockKey)
                    }
                }
            })
        }
    }
}