//
//  PhotoVC.swift
//  Spotlight
//
//  Created by Odin on 2016-08-21.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {
    var photoInfoKey: PhotoInfoKey?
    var photo: Photo?
    
    var container: PhotoViewContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
        
        guard photoInfoKey != nil else {
            Log.error("photo info key should have been set on segue")
            return
        }
        
        ModelInterface.sharedInstance.downloadPhoto(photoInfoKey!) { (photo, err) in
            guard err == nil else {
                Log.error(err.debugDescription)
                return
            }
            
            guard photo != nil else {
                Log.error("photo should have been downloaded already")
                return
            }
            
            guard photo?.photoInfo != nil else {
                Log.error("photo info should not be null")
                return
            }
            
            
            self.photo = photo
            
            self.container?.loadImage((photo?.photoImage)!)
            self.container?.loadDescription(photo!.photoInfo!.description!)
            
        }
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = PhotoViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
    
    func setKey(key: PhotoInfoKey) {
        self.photoInfoKey = key
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.toSingleMap {
            guard photo?.photoInfo != nil || photoInfoKey != nil else {
                Log.error("PhotoInfo or photo info key cannot be null when going to map view")
                return
            }
            
            let singleMapView = segue.destinationViewController as! MapViewVC
            singleMapView.setPhotoInfo((photo?.photoInfo)!, photoInfoKey: photoInfoKey!)
        }
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PhotoVC: PhotoViewContainerDelegate {
    func goBackToGridView() {
        performSegueWithIdentifier(Segues.toGridView, sender: self)
    }
    func goToMapView() {
        performSegueWithIdentifier(Segues.toSingleMap, sender: self)
    }
}
