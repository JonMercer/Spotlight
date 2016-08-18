//
//  CameraVC.swift
//  Spotlight
//
//  Created by Odin on 2016-06-26.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit
import CoreLocation

class CameraVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var container: CameraViewContainer?
    
    //TODO: delete these @IB* when no one will conflict with the storyboard
    @IBOutlet var PhotoView: UIImageView!
    @IBOutlet var PhotoView2: UIImageView!
    @IBAction func CaptureImage(sender: AnyObject) {}
    @IBAction func GetImageFromAlbums(sender: AnyObject) {}
    @IBAction func SaveButton(sender: AnyObject) {}
    @IBAction func saveLocally(sender: AnyObject) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
        
        Location.sharedInstance.startGettingLoc()
        
        
        //TODO: authenticate user sign in
        let signedIn = ModelInterface.sharedInstance.isSignedIn()
        
        if(!signedIn) {
            ModelInterface.sharedInstance.signIn({ (err) in
                Log.error("Couldn't sign in user")
                //TODO: handle error
            })
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = CameraViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
}

//MARK: - CameraViewContainerDelegate, PhotoEntityEditor
extension CameraVC: CameraViewContainerDelegate {
    
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
    
    func publishImage(image: UIImage, description: String) {
        var photo = Photo(image: image)
        photo.photoInfo = ModelInterface.sharedInstance.createPhotoInfo()
        
        photo.resizePhotoImage()
        photo.resizeIconImage()
        
        ModelInterface.sharedInstance.uploadPhoto(photo) { (err) in
            if err != nil {
                //TODO: let the user know SL-168
                Log.error(err.debugDescription)
            } else {
                ModelInterface.sharedInstance.uploadPhotoInfo(photo, completed: { (err) in
                    //TODO: let the user know SL-168
                    Log.error(err.debugDescription)
                })
            }
        }
    }
}


