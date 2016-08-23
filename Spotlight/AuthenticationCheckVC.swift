//
//  AuthenticationCheckVC.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-22.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit
import Firebase

class AuthenticationCheckVC: UIViewController {
    override func viewDidAppear(animated: Bool) {
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if user != nil {
                Log.info("user is signed in")
                self.performSegueWithIdentifier(Segues.toLoadingView, sender: self)
            } else {
                Log.info("user not signed in")
                self.performSegueWithIdentifier(Segues.toLoginView, sender: self)
            }
        }
    }
}
