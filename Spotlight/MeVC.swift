//
//  NearMeVC.swift
//  Spotlight
//
//  Created by Odin on 2016-07-18.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase

class MeVC: UIViewController {
    var container: MeViewContainer?
    var interstitial: GADInterstitial!
    var photoInfoKeysInGrid: [PhotoInfoKey]?
    
    var selectedCellIndexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grabMyPhotoInfoKeys {
            self.setupViewContainer()
        }
        
        createAndLoadInterstitial()
        // play ad every 5 minutes
        //NSTimer.scheduledTimerWithTimeInterval(300, target: self, selector: #selector(NearMeVC.addFullScreenAd), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        Log.error("memory warning!!")
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = MeViewContainer.instanceFromNib(
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
        if segue.identifier == Segues.toPhotoView {
            guard photoInfoKeysInGrid != nil else {
                Log.error("list of photo info keys should have been loaded by now")
                return
            }
            
            let photoView = segue.destinationViewController as! PhotoVC
            let index = selectedCellIndexPath!.row
            
            photoView.setKey(photoInfoKeysInGrid![index])
        }
    }
}

//MARK: - NearMeViewContainerDelegate
extension MeVC: MeViewContainerDelegate {
    func populateImage(cellImage: UIImageView, index: Int) {
        guard self.photoInfoKeysInGrid != nil else {
            Log.error("PhotoInfoKeys should not be nil because grabPhotoEntityKeysInBigGeoBlocks() should have populated it")
            return
        }
        ModelInterface.sharedInstance.downloadPhotoIcon(self.photoInfoKeysInGrid![index]) { (photo, err) in
            guard err == nil else {
                Log.error(err.debugDescription)
                return
            }
            
            cellImage.image = photo?.photoImage
        }
    }
    
    func grabMyPhotoInfoKeys(completion: () -> ()) {
        let userKey = FIRAuth.auth()?.currentUser?.uid
        
        guard userKey != nil else {
            Log.error("user is not signed in")
            //TODO: SL-192
            return
        }
        
        ModelInterface.sharedInstance.downloadUserPhotoInfoKeys(userKey!) { (photoInfoKeys, err) in
            guard err == nil else {
                Log.error(err.debugDescription)
                return
            }
            self.photoInfoKeysInGrid = photoInfoKeys
            completion()
        }
    }
    
    func getNumberOfCellImages() -> Int {
        return self.photoInfoKeysInGrid!.count
    }
    
    func collectionIndexSelected(index: NSIndexPath) {
        self.selectedCellIndexPath = index
        self.performSegueWithIdentifier(Segues.toPhotoView, sender: self)
    }
    
}


