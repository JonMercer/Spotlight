//
//  ViewController.swift
//  Spotlight
//
//  Created by Odin on 2016-06-26.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class MeVC: UIViewController{
    
    @IBOutlet var TakenPhotoView: UIImageView!
    @IBAction func LoadTakenPhoto(sender: AnyObject) {
        
//        func getPhotoFilePath()
        // Assume the file is stored in the app's file system.  Now retrieve it and convert it back to an image.
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
        
        let fileName = Constants.tempPathName // temporary file name for testing.  change this later.

        let filePath = (documentsDirectory as NSString).stringByAppendingPathComponent(fileName)

        
        TakenPhotoView.image = LocalStoragePhotoManager.loadLocalImage(filePath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

