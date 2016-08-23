//
//  LoginVC.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-22.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    var container: LoginViewContainer?
    
    override func viewDidLoad() {
        Log.test("loaded login view")
        
        setupViewContainer()
        Location.sharedInstance.startGettingLoc()
    }
    
    override func didReceiveMemoryWarning() {
        //
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = LoginViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
    
    private func signUpFailAlert() {
        let alert = UIAlertController(title: "Oops", message: "Could not sign you up!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func loginFailAlert() {
        let alert = UIAlertController(title: "Oops", message: "Could not log you in!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }


}

extension LoginVC: LoginViewContainerDelegate {
    func loginInUser(email: String?, pass: String?) {
        guard email != nil || pass != nil else {
            loginFailAlert()
            return
        }
        FIRAuth.auth()?.signInWithEmail(email!, password: pass!) { (user, error) in
            guard error == nil else {
                self.loginFailAlert()
                return
            }
            
            self.performSegueWithIdentifier(Segues.toTabView, sender: self)
        }
        
    }
    
    func signUpUser(email: String?, pass: String?, name: String?) {
        guard email != nil || pass != nil || name != nil else {
            Log.test("nils")
            signUpFailAlert()
            return
        }
        
        FIRAuth.auth()?.createUserWithEmail(email!, password: pass!, completion: { (user, error) in
            guard error == nil else {
                Log.test("create user error")
                self.signUpFailAlert()
                return
            }
            
            let firebaseRef = FIRDatabase.database().reference()
            
            let userKey = FIRAuth.auth()?.currentUser?.uid
            
            let userInfoAddress = "/\(PermanentConstants.realTimeDatabaseUserInfo)/\(userKey!)/\("Name")/"
   
            let childUpdates = [userInfoAddress: name!]
            
            firebaseRef.updateChildValues(childUpdates, withCompletionBlock: {(error,ref) in
                if(error != nil) {
                    Log.error("Could not add name of user to database")
                    Log.test("could not add name")
                    self.signUpFailAlert()
                } else {
                    self.performSegueWithIdentifier(Segues.toTabView, sender: self)
                }
            })

        })
        

        // then set their name in database to the username
    }
}
