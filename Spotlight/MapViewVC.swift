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
    //SL-210
    var photoInfoKey: PhotoInfoKey?
    var photoInfo: PhotoInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
        
        guard photoInfo != nil else {
            Log.error("photoInfo should have been instantiated on segue")
            return
        }
        container?.lat = photoInfo!.lat
        container?.lon = photoInfo!.lon
        container?.loadLatLonOnMap()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        Log.error("memory warning!!")
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = MapViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
    
    func setPhotoInfo(photoInfo: PhotoInfo, photoInfoKey: PhotoInfoKey) {
        self.photoInfo = photoInfo
        self.photoInfoKey = photoInfoKey
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == Segues.toPhotoView {
            guard photoInfoKey != nil else {
                Log.error("photoInfo key should have been loaded on segue")
                return
            }
            
            let photoView = segue.destinationViewController as! PhotoVC
            photoView.setKey(photoInfoKey!)
        }
    }
}

//MARK: - MapViewContainerDelegate
extension MapViewVC: MapViewContainerDelegate {
    func goBackToPhotoView() {
        performSegueWithIdentifier(Segues.toPhotoView, sender: self)
    }
}
