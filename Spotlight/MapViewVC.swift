//
//  MapViewVC.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-07-25.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MapViewVC: UIViewController {
    var container: MapViewContainer?
    var lat: CLLocationDegrees = 0.0
    var lon: CLLocationDegrees = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
        Log.debug("lat: \(lat) lon: \(lon)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = MapViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        //container?.delegate = self
        view.addSubview(container!)
    }
}