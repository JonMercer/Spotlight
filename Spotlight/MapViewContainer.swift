//
//  MapViewContainer.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-07-25.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MapViewContainer: UIView {
    
    @IBOutlet weak var singleMapView: UIView!
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> MapViewContainer {
        let view = UINib(nibName: "MapViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! MapViewContainer
        view.frame = frame
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

