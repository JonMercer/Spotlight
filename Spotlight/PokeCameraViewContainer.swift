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
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var publishButton: UIButton!
    
    @IBAction func cancelButton(sender: AnyObject) {
        delegate?.goBackGridView()
    }
    
    @IBAction func publishImageButtonPressed(sender: AnyObject) {
        if let photo = photoView.image {
            delegate?.publishImage(photo, completion: {
                self.delegate?.goToSingleMapView()
            })
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
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        cancelButton.layer.cornerRadius = 8
        cancelButton.layer.borderWidth = CGFloat(1.2)
        cancelButton.layer.borderColor = cancelButton.titleLabel?.textColor.CGColor
        
        publishButton.layer.cornerRadius = 8
        publishButton.layer.borderWidth = CGFloat(1.2)
        publishButton.layer.borderColor = publishButton.titleLabel?.textColor.CGColor
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        delegate?.goToCameraPicker(picker)
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
    func publishImage(image: UIImage, completion: () -> ())
    func getLocation(photoID: PhotoEntityKey, completion: (lat: CLLocationDegrees, lon: CLLocationDegrees) -> Void)
    func goBackGridView()
    func goToSingleMapView()
}
