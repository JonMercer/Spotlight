//
//  NearMeViewContainer.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-07-18.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class NearMeViewContainer: UIView {
    var delegate: NearMeViewContainerDelegate?
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> NearMeViewContainer {
        let view = UINib(nibName: "NearMeViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! NearMeViewContainer
        view.frame = frame
        return view
    }
}

//MARK: - NearMeViewContainerDelegate
protocol NearMeViewContainerDelegate {
}