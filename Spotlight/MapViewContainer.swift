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
import GoogleMaps

class MapViewContainer: UIView {
    var delegate: MapViewContainerDelegate?
    
    @IBOutlet weak var singleMapView: GMSMapView!
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> MapViewContainer {
        let view = UINib(nibName: "MapViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! MapViewContainer
        view.frame = frame
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Log.debug("awoke")
        delegate?.getMapLocation({ (lat, lon) in
            Log.debug("lat: \(lat) lon: \(lon)")
            let camera = GMSCameraPosition.cameraWithLatitude(lat,longitude: lon, zoom: 6)
            self.singleMapView.camera = camera
            self.singleMapView.myLocationEnabled = true
            
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(lat,lon)
            //marker.title = "Sydney"
            //marker.snippet = "Australia"
            marker.map = self.singleMapView
        })
    }
}

//MARK: - MapViewContainerDelegate
protocol MapViewContainerDelegate {
    func getMapLocation(completion: (lat: CLLocationDegrees, lon: CLLocationDegrees) -> ())
}

