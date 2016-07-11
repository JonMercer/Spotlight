//
//  FirebaseAuthentication.swift
//  Spotlight
//
//  Created by Odin on 2016-07-10.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Firebase

extension ModelInterface: Authenticate {
    
    func isUserSignedIn(completionHandler: (signedIn: Bool) -> ()) {
        if let user = FIRAuth.auth()?.currentUser {
            print("user:\(user.email) created an entry")
            completionHandler(signedIn: true)
        } else {
            print("user is not signed in.")
            completionHandler(signedIn: false)
        }
    }
}