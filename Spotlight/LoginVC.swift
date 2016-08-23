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

}

extension LoginVC: LoginViewContainerDelegate {
    
}
