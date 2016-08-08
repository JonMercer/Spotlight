//
//  PokeCameraVC.swift
//  Spotlight
//
//  Created by Odin on 2016-06-26.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit
import CoreLocation

class PokeCameraVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var container: PokeCameraViewContainer?
    var photoEntityLastUploaded: PhotoEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
        
        Location.sharedInstance.startGettingLoc()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = PokeCameraViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Segues.toSingleMap {
            let singleMapView = segue.destinationViewController as! MapViewVC
            
            singleMapView.setUpLatLonOfMap(photoEntityLastUploaded!.getPhotoID())
        }
    }
}

//MARK: - CameraViewContainerDelegate, PhotoEntityEditor
extension PokeCameraVC: PokeCameraViewContainerDelegate {
    
    func goToCameraPicker(picker: UIImagePickerController) {
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func dismissViewControllerAnimated() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func publishImage(image: UIImage, completion: () -> ()) {
        ModelInterface.sharedInstance.savePhotoLocally(Photo(image: image), completed: { (err) in
            //TODO delete this
        })
        var urls = ModelInterface.sharedInstance.getImageURLsInDirectory()
        urls.sortInPlace({ $0.lastPathComponent<$1.lastPathComponent })
        Log.debug("\(urls.last!.lastPathComponent)")
        //ModelInterface.sharedInstance.uploadPhoto(urls.last!) { (err) in
            //TODO: handle error
        //}
        self.createPhotoEntity(urls.last!.lastPathComponent!) {
            (photoEntity: PhotoEntity) in
            self.photoEntityLastUploaded = photoEntity
            completion()
        }
        
    }
    
    func getLocation(photoID: PhotoEntityKey, completion: (lat: CLLocationDegrees, lon: CLLocationDegrees) -> Void) {
        self.getPhotoEntity(photoID) { (photoEntity) in
            completion(lat: photoEntity.getLat(photoID), lon: photoEntity.getLon(photoID))
        }
    }
    
    func goBackGridView() {
        performSegueWithIdentifier(Segues.toGridView, sender: self)
    }
    
    func goToSingleMapView() {
        performSegueWithIdentifier(Segues.toSingleMap, sender: self)
    }
}


//MARK: - PhotoEntityEditor
extension PokeCameraVC: PhotoEntityEditor {
    
}

//MARK: - PhotoEntities (might delete)
extension PokeCameraVC: PhotoEntities {
    
}


