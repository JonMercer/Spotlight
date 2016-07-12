//
//  CameraViewContainer.swift
//  Spotlight
//
//  Created by Odin on 2016-07-11.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class CameraViewContainer: UIView {
    
    class func instanceFromNib(frame: CGRect) -> CameraViewContainer {
        let view = UINib(nibName: "CameraViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CameraViewContainer
        view.frame = frame
        return view
    }
}