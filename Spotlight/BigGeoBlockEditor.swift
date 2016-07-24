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
    func sortGeoBlocks(listOfGeoBlockKeys: [GeoBlockKey], completion: (sortedListOfGeoBlockKey: [GeoBlockKey])-> ())
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
        
    }
}