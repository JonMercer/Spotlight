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
    
    let photoAlbum = PhotoAlbum()
    
    @IBOutlet var PhotoView: UIImageView!
    @IBOutlet var PhotoView2: UIImageView!

    @IBAction func CaptureImage(sender: AnyObject) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func GetImageFromAlbums(sender: AnyObject) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func SaveButton(sender: AnyObject) {
        saveImage()
    }
    
    
    func saveImage() {
        UIImageWriteToSavedPhotosAlbum(PhotoView.image!, nil, nil, nil)
        //photoAlbum.saveImage(PhotoView.image!)
        CustomPhotoAlbum.sharedInstance.saveImage(PhotoView.image!)
    }
    
    // Here's the main StackOverFlow page YK used for reference for the following function:
    // http://stackoverflow.com/questions/30671967/storing-images-to-coredata-swift
    @IBAction func saveLocally(sender: AnyObject) {
        
        let filePath = LocalStoragePhotoManager.saveImageLocal(PhotoView.image!)

        PhotoView2.image = LocalStoragePhotoManager.loadLocalImage(filePath)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        PhotoView.image = info [UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //For stop
        //manager.stopUpdatingLocation()
        //manager.allowsBackgroundLocationUpdates = false
        
        setupViewContainer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = CameraViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
}

//MARK: - CameraViewContainerDelegate
extension CameraVC: CameraViewContainerDelegate {
    
    func goToCameraPicker(picker: UIImagePickerController) {
        presentViewController(picker, animated: true, completion: nil)
    }
}

