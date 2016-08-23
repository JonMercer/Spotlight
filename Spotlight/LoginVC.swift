//
//  LoginVC.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-22.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    var container: LoginViewContainer?
    
    override func viewDidLoad() {
        Log.test("loaded login view")
        
        setupViewContainer()
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


}

extension LoginVC: LoginViewContainerDelegate {
    func loginInUser(email: String?, pass: String?) {
        // check if values nil and alert
        // otherwise log in
    }
    func signUpUser(email: String?, pass: String?, name: String?) {
        // check if values nil and alert
        // otherwise create new user with email and pass
        // then set their name in database to the username
    }
}
