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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
        
        LocationManager.sharedInstance.startGettingLoc()
        
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
}

//MARK: - CameraViewContainerDelegate, PhotoEntityEditor
extension PokeCameraVC: PokeCameraViewContainerDelegate {
    
    func goToCameraPicker(picker: UIImagePickerController) {
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func dismissViewControllerAnimated() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveToCameraRoll(image: UIImage) {
        //TODO: do I actually need to run this line?
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        CustomPhotoAlbum.sharedInstance.saveImage(image)
        
    }
    
    func publishImage(image: UIImage) {
        LocalStoragePhotoManager.saveImageLocal(image)
        var urls = LocalStoragePhotoManager.getImageURLsInDirectory()
        urls.sortInPlace({ $0.lastPathComponent<$1.lastPathComponent })
        ModelInterface.sharedInstance.uploadPhoto(urls.last!) { (err) in
            //TODO: handle error
        }
        
        self.createPhotoEntity(urls.last!.lastPathComponent!) {
            (photoEntity: PhotoEntity) in
            //TODO: handle
        }
        
    }
    
    func getLocation(photoID: PhotoEntityKey, completion: (lat: CLLocationDegrees, lon: CLLocationDegrees) -> Void) {
        self.getPhotoEntity(photoID) { (photoEntity) in
            completion(lat: photoEntity.getLat(photoID), lon: photoEntity.getLon(photoID))
        }
    }
}


//MARK: - PhotoEntityEditor
extension PokeCameraVC: PhotoEntityEditor {
    
}

//MARK: - PhotoEntities (might delete)
extension PokeCameraVC: PhotoEntities {
    
}


