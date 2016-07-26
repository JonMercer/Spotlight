//
//  PokeCameraViewContainer.swift
//  Spotlight
//
//  Created by Odin on 2016-07-11.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

//MARK: - PokeCameraViewContainer
class PokeCameraViewContainer: UIView {
    var delegate: PokeCameraViewContainerDelegate?
    
//    //MARK: - UI Elements
    @IBOutlet var photoView: UIImageView!
    
    @IBAction func captureImageFromAlbumButtonPressed(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        delegate?.goToCameraPicker(picker)
    }
    
    @IBAction func publishImageButtonPressed(sender: AnyObject) {
        if let photo = photoView.image {
            delegate?.publishImage(photo)
        } else {
            Log.error("Image view is empty")
        }
    }
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> PokeCameraViewContainer {
        let view = UINib(nibName: "PokeCameraViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PokeCameraViewContainer
        view.frame = frame
        return view
    }
}

//MARK: - UIImagePickerControllerDelegate
extension PokeCameraViewContainer: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        photoView.image = info [UIImagePickerControllerOriginalImage] as? UIImage
        
        //TODO: find a better way of doing this
        delegate?.dismissViewControllerAnimated()
    }
}

//MARK: - UINavigationControllerDelegate
extension PokeCameraViewContainer: UINavigationControllerDelegate {
    //Had to add this for color picker for some reason
}

//MARK: - PokeCameraViewContainerDelegate
protocol PokeCameraViewContainerDelegate {
    func goToCameraPicker(picker: UIImagePickerController)
    func dismissViewControllerAnimated()
    func saveToCameraRoll(image: UIImage)
    func publishImage(image: UIImage)
    func getLocation(photoID: PhotoEntityKey, completion: (lat: CLLocationDegrees, lon: CLLocationDegrees) -> Void)
}
