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
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> LoginViewContainer {
        let view = UINib(nibName: "LoginViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! LoginViewContainer
        view.frame = frame
        return view
    }
}

protocol LoginViewContainerDelegate {
    //
}
