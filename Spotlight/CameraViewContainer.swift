//
//  CameraViewContainer.swift
//  Spotlight
//
//  Created by Odin on 2016-07-11.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

//MARK: - CameraViewContainer
class CameraViewContainer: UIView {
    var delegate: CameraViewContainerDelegate?

    override func willMoveToSuperview(newSuperview: UIView?) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CameraViewContainer.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CameraViewContainer.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    //MARK: - UI Elements
    @IBOutlet var photoView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
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
            Log.error("Image view is empty")
        }
    }
    
    @IBAction func publishImageButtonPressed(sender: AnyObject) {
        if let photo = photoView.image {
            var descriptionText = ""
            if descriptionTextView.text != UIConstants.description {
                descriptionText = descriptionTextView.text
            }
            
            Log.test(descriptionText)
            
            delegate?.publishImage(photo, description: descriptionText)
            
            //TODO: this crashes the app. Should re-do it
//            delegate?.getLocation(Constants.keySupposedToBeInFIR, completion: { (lat, lon) in
//                let camera = GMSCameraPosition.cameraWithLatitude(lat,longitude: lon, zoom: 6)
//                self.mapView.camera = camera
//                self.mapView.myLocationEnabled = true
//            
//                
//                let marker = GMSMarker()
//                marker.position = CLLocationCoordinate2DMake(lat,lon)
//                marker.title = "Sydney"
//                marker.snippet = "Australia"
//                marker.map = self.mapView
//            })
            
            
        } else {
            Log.error("Image view is empty")
        }
    }
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> CameraViewContainer {
        let view = UINib(nibName: "CameraViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! CameraViewContainer
        view.frame = frame
        return view
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue(){
            if self.frame.origin.y == 0{
                self.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            if self.frame.origin.y != 0 {
                self.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        self.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
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

//MARK: - CameraViewContainerDelegate
protocol CameraViewContainerDelegate {
    func goToCameraPicker(picker: UIImagePickerController)
    func dismissViewControllerAnimated()
    func saveToCameraRoll(image: UIImage)
    func publishImage(image: UIImage, description: String)
}
