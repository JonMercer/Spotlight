//
//  LoginViewContainer.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-22.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class LoginViewContainer: UIView {
    var delegate: LoginViewContainerDelegate?
    
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    
    @IBAction func signUpButton(sender: AnyObject) {
        delegate?.signUpUser(emailTextField.text, pass: passTextField.text, name: nameTextField.text)
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        delegate?.loginInUser(emailTextField.text, pass: passTextField.text)
    }
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> LoginViewContainer {
        let view = UINib(nibName: "LoginViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! LoginViewContainer
        view.frame = frame
        return view
    }
    
}

protocol LoginViewContainerDelegate {
    func loginInUser(email: String?, pass: String?)
    func signUpUser(email: String?, pass: String?, name: String?)
}
