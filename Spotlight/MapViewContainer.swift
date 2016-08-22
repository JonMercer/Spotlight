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
    var lat: CLLocationDegrees?
    var lon: CLLocationDegrees?
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButton(sender: AnyObject) {
        delegate?.goBackToPhotoView()
    }
    
    @IBOutlet weak var singleMapView: GMSMapView!
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> MapViewContainer {
        let view = UINib(nibName: "MapViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! MapViewContainer
        view.frame = frame
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        backButton.layer.cornerRadius = 8
        backButton.layer.borderWidth = CGFloat(1.2)
        backButton.layer.borderColor = backButton.titleLabel?.textColor.CGColor
    }
    
    func loadLatLonOnMap() {
        guard lat != nil || lon != nil else {
            Log.error("lat and lon should have been set on segue")
            return
        }
        
        Log.debug("lat: \(lat) lon: \(lon)")
        let camera = GMSCameraPosition.cameraWithLatitude(lat!,longitude: lon!, zoom: Constants.zoomLevel)
        self.singleMapView.camera = camera
        self.singleMapView.myLocationEnabled = true
        
        let marker = GMSMarker()
        marker.icon = UIImage(named: "PokeMarker")
        marker.position = CLLocationCoordinate2DMake(lat!,lon!)
        //marker.title = "Sydney"
        //marker.snippet = "Australia"
        marker.map = self.singleMapView    }
}

//MARK: - MapViewContainerDelegate
protocol MapViewContainerDelegate {
    func goBackToPhotoView()
}

