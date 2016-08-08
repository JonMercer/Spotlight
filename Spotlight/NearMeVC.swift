//
//  NearMeVC.swift
//  Spotlight
//
//  Created by Odin on 2016-07-18.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit
import GoogleMobileAds

class NearMeVC: UIViewController {
    var container: NearMeViewContainer?
    var interstitial: GADInterstitial!
    var photoEntitiesInGrid: [PhotoEntityKey]?
    
    var selectedCellIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grabPhotoEntityKeysInBigGeoBlocks {
            self.setupViewContainer()
        }
        
        createAndLoadInterstitial()
        // play ad every 5 minutes
        NSTimer.scheduledTimerWithTimeInterval(300, target: self, selector: #selector(NearMeVC.addFullScreenAd), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        Log.error("memory warning!!")
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = NearMeViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
    
    // for ads
    private func createAndLoadInterstitial() {
        interstitial = GADInterstitial(adUnitID: Constants.AdmobID)
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b" ]
        interstitial.loadRequest(request)
    }
    
    func addFullScreenAd() {
        Log.debug("run")
        if interstitial.isReady {
            interstitial.presentFromRootViewController(self)
        } else {
            Log.error("Ad wasn't ready")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.toSingleMap {
            let singleMapView = segue.destinationViewController as! MapViewVC
            let index = selectedCellIndexPath!.row
            
            if(photoEntitiesInGrid != nil) {
                singleMapView.setUpLatLonOfMap(photoEntitiesInGrid![index])
            } else {
                Log.error("photoEntitiesInGrid was not set and shouldn't have been empty")
            }
        }
    }
}

//MARK: - NearMeViewContainerDelegate
extension NearMeVC: NearMeViewContainerDelegate {
    func populateImage(cellImage: UIImageView, index: Int) {
//        if(self.photoEntitiesInGrid != nil) {
//            self.getPhotoEntity(self.photoEntitiesInGrid![index], completion: { (photoEntity) in
//                ModelInterface.sharedInstance.downloadPhotoByName(photoEntity.getPhotoName()) { (err, image) in
//                    cellImage.image = image
//                }
//            })
//        }
        
    }
    
    func grabPhotoEntityKeysInBigGeoBlocks(completion: () -> ()) {
//        let currentBigBlockKey = GeoUtil.getBigGeoBlockKeyByCurrentLatLon()
//        Log.debug(currentBigBlockKey)
//        getNeighbouringBigGeoBlockContent(currentBigBlockKey) { (listOfGeoBlockKeys) in
//            self.getPhotoKeysInGeoBlocks(listOfGeoBlockKeys, completion: { (listOfPhotoEntities) in
//                self.photoEntitiesInGrid = listOfPhotoEntities
//                completion()
//            })
//        }
    }
    
    func getNumberOfCellImages() -> Int {
        return self.photoEntitiesInGrid!.count
    }
    
    func collectionIndexSelected(index: NSIndexPath) {
        self.selectedCellIndexPath = index
        self.performSegueWithIdentifier(Segues.toSingleMap, sender: self)
    }
    
}


//MARK: - PhotoEntityEditor
extension NearMeVC: PhotoEntityEditor {
    
}
