//
//  AuthInterface.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-06.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Firebase

/// Handles all of the user authentication
/// - Todo: consider changing authentication method to phone numbers or Facebook
protocol AuthInterfaceProtocol {
    /// Signs in the user on this device
    func signIn(completed: (err: ErrorType?) -> ())
    
    /// Creates an user with the app's unique ID on the device
    func createUser(completed: (err: ErrorType) -> ())
    
    /// Signs out the user on this device
    /// - Requires: the user to be signed in and to exist
    func signOut(completed: (err: ErrorType?) -> ())
    
    /// Sets the current user's display username
    /// - Parameter name: the new username to set
    /// - Requires: the user to be signed in and to exist
    func setUsername(name: Username, completed: (err: ErrorType) -> ())
    
    /// Checks whether the current user is signed in or not.
    /// - Requires: the current user to be created??????????????????????????????
    /// - Returns: true being signed in or false
    func isSignedIn() -> Bool
}

extension ModelInterface: AuthInterfaceProtocol {
    func signIn(completed: (err: ErrorType?) -> ()) {
        //TODO: make phone number not unique ID
        let identifier: String = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        FIRAuth.auth()?.signInWithEmail("\(identifier)\(FirebaseConstants.emailDomain)", password: identifier) { (user, error) in
            if (error != nil) {
                completed(err: AuthError.FailedSignIn)
            } else {
                completed(err: nil)
            }
        }
    }
    
    
    func createUser(completed: (err: ErrorType) -> ()) {
        //TODO: make phone number not unique ID
        let identifier: String = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        // The password is the unique ID
        FIRAuth.auth()?.createUserWithEmail("\(identifier)\(FirebaseConstants.emailDomain)", password: identifier) { (user, error) in
            if (error != nil) {
                completed(err: AuthError.FailedUserCreation)
            }
        }
    }
    
    func signOut(completed: (err: ErrorType?) -> ()) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            completed(err: AuthError.FailedSignOut)
        }
    }
    
    func setUsername(name: Username, completed: (err: ErrorType) -> ()) {
        let firebaseRef = FIRDatabase.database().reference()
        let userKey = FIRAuth.auth()?.currentUser?.uid
        let userInfoAddress = "/\(PermanentConstants.realTimeDatabaseUserInfo)/\(userKey)/username/"
        
        let update = [userInfoAddress: name]
        
        firebaseRef.updateChildValues(update, withCompletionBlock: {(error,ref) in
            if(error != nil) {
                completed(err: AuthError.FailedSetUsername)
            } else {
                //TODO: return username
                //completed(username: name)
            }
        })
    }
    
    
    func isSignedIn() -> Bool {
        if (FIRAuth.auth()?.currentUser) != nil {
            return true;
        } else {
            return false;
        }
    }
}