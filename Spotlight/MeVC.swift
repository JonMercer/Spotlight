//
//  ViewController.swift
//  Spotlight
//
//  Created by Odin on 2016-06-26.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

/*

 ___     _      _
 /   \___| | ___| |_ ___   _ __ ___   ___
 / /\ / _ \ |/ _ \ __/ _ \ | '_ ` _ \ / _ \
 / /_//  __/ |  __/ ||  __/ | | | | | |  __/
 /___,' \___|_|\___|\__\___| |_| |_| |_|\___|
 

 */

import UIKit

class MeVC: UIViewController{
    let photoManager = DeviceOwnerPhotoManager()
    
    @IBOutlet var TakenPhotoView: UIImageView!
    @IBAction func LoadTakenPhoto(sender: AnyObject) {
        
//        func getPhotoFilePath()
        // Assume the file is stored in the app's file system.  Now retrieve it and convert it back to an image.
        let fileName = Constants.tempPathName // temporary file name for testing.  change this later.
        
        
        let filePath = (FilePathConstants.directoryStringPath as NSString).stringByAppendingPathComponent(fileName)

        
        TakenPhotoView.image = ModelInterface.sharedInstance.loadLocalImage(filePath)
    }
    
    
    @IBAction func previousImageButton(sender: AnyObject) {
        TakenPhotoView.image = photoManager.prevImage()
    }
    
    
    @IBAction func nextImageButton(sender: AnyObject) {
        TakenPhotoView.image = photoManager.nextImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LocationManager.sharedInstance.stopGettingLoc()
        photoManager.updateImages()
        
        TakenPhotoView.image = photoManager.getFirstImage()
        
        let prev = UISwipeGestureRecognizer(target: self, action: #selector(MeVC.handleSwipes(_:)))
        let next = UISwipeGestureRecognizer(target: self, action: #selector(MeVC.handleSwipes(_:)))
        
        // Do any additional setup after loading the view, typically from a nib.
        prev.direction = .Right
        next.direction = .Left
        
        view.addGestureRecognizer(prev)
        view.addGestureRecognizer(next)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Left) {
            TakenPhotoView.image = photoManager.nextImage()
        } else if (sender.direction == .Right) {
            TakenPhotoView.image = photoManager.prevImage()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

