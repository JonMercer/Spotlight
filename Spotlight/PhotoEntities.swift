//
//  PhotoEntities.swift
//  Spotlight
//
//  Created by Odin on 2016-07-24.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

protocol PhotoEntities {
    func grabKeysOfAllEntities(completion: (photoEntityKeys: [PhotoEntityKey]) -> ())
}

extension PhotoEntities {
    func grabKeysOfAllEntities(completion: (photoEntityKeys: [PhotoEntityKey]) -> ()) {
        let firebaseRef = FIRDatabase.database().reference()
        
        firebaseRef.child("PhotoEntities").observeSingleEventOfType(.Value, withBlock: { (snapshot) in

            var listOfKeys = [PhotoEntityKey]()
            for child in snapshot.children {
                listOfKeys.append(child.key)
            }
            
            if !listOfKeys.isEmpty {
                completion(photoEntityKeys: listOfKeys)
            } else {
                Log.error("List of children is empty")
            }
            
        }) { (error) in
            Log.error(error.localizedDescription)
        }
    }
}

