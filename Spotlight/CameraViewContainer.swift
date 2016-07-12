//
//  CameraViewContainer.swift
//  Spotlight
//
//  Created by Odin on 2016-07-11.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

protocol CameraViewContainerDelegate {
    func goToCameraPicker(picker: UIImagePickerController)
    func dismissViewControllerAnimated()
    func saveToCameraRoll(image: UIImage)
}


class CameraViewContainer: UIView {
    var delegate: CameraViewContainerDelegate?
    
    
    //MARK: - UI Elements
    
    @IBOutlet var photoView: UIImageView!
    @IBOutlet var debuggingPhotoView: UIImageView!
    
    @IBAction func captureImageFromCameraButtonPressed(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera

        delegate?.goToCameraPicker(picker)
    }
    
    @IBAction func captureImageFromAlbumButtonPressed(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
       delegate?.goToCameraPicker(picker)
    }
    
    @IBAction func saveImageToCameraRollButtonPressed(sender: AnyObject) {
        if let photo = photoView.image {
            delegate?.saveToCameraRoll(photo)
        } else {
            print("ERROR \(NSDate().timeStamp()): image view is empty")
        }
    }
    
    class func instanceFromNib(frame: CGRect) -> CameraViewContainer {
        let view = UINib(nibName: "CameraViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CameraViewContainer
        view.frame = frame
        return view
    }
}

//MARK: - UIImagePickerControllerDelegate
extension CameraViewContainer: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        photoView.image = info [UIImagePickerControllerOriginalImage] as? UIImage

        //TODO: find a better way of doing this
        delegate?.dismissViewControllerAnimated()
    }
}


//MARK: - UINavigationControllerDelegate
extension CameraViewContainer: UINavigationControllerDelegate {
    //Had to add this for color picker for some reason
}