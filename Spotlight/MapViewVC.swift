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
    var selectedImagePhotoEntityKey: PhotoEntityKey?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
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
    
    func setUpLatLonOfMap(photoEntityKey: PhotoEntityKey) {
        selectedImagePhotoEntityKey = photoEntityKey
    }
}

//MARK: - MapViewContainerDelegate
extension MapViewVC: MapViewContainerDelegate {
    func getMapLocation(completion: (lat: CLLocationDegrees, lon: CLLocationDegrees) -> ()) {
        self.getPhotoEntity(self.selectedImagePhotoEntityKey!, completion: { (photoEntity) in
            completion(lat: photoEntity.lat, lon: photoEntity.lon)
        })
    }
    
    func goBackGridView() {
        performSegueWithIdentifier(Segues.toGridView, sender: self)
    }
}

//MARK: - PhotoEntityEditor
extension MapViewVC: PhotoEntityEditor {
}