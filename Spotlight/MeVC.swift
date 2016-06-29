//
//  ViewController.swift
//  Spotlight
//
//  Created by Odin on 2016-06-26.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class MeVC: UIViewController{
    let photoManager = DeviceOwnerPhotoManager()
    
    @IBOutlet var TakenPhotoView: UIImageView!
    @IBAction func LoadTakenPhoto(sender: AnyObject) {
        
//        func getPhotoFilePath()
        // Assume the file is stored in the app's file system.  Now retrieve it and convert it back to an image.
        let fileName = Constants.tempPathName // temporary file name for testing.  change this later.
        
        
        let filePath = (FilePathConstants.directoryStringPath as NSString).stringByAppendingPathComponent(fileName)

        
        TakenPhotoView.image = LocalStoragePhotoManager.loadLocalImage(filePath)
    }
    
    
    @IBAction func previousImageButton(sender: AnyObject) {
        TakenPhotoView.image = photoManager.prevImage()
    }
    
    
    @IBAction func nextImageButton(sender: AnyObject) {
        TakenPhotoView.image = photoManager.nextImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoManager.updateImages()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

