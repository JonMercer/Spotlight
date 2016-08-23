//
//  AuthenticationCheckVC.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-22.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class AuthenticationCheckVC: UIViewController {
    override func viewDidAppear(animated: Bool) {        
        ModelInterface.sharedInstance.signIn { (err) in
            guard err == nil else {
                Log.debug("couldn't sign in")
                self.performSegueWithIdentifier(Segues.toLoginView, sender: self)
                return
            }
            
            self.performSegueWithIdentifier(Segues.toLoadingView, sender: self)
        }
        
        
    }

}
