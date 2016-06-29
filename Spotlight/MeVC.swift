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
        let fileName = Constants.tempPathName // temporary file name for testing.  change this later.

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try NSFileManager.defaultManager().contentsOfDirectoryAtURL( FilePathConstants.directoryURLPath, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            let mp3Files = directoryContents.filter{ $0.pathExtension == "jpg" }
            print("mp3 urls:",mp3Files)
            let mp3FileNames = mp3Files.flatMap({$0.URLByDeletingPathExtension?.lastPathComponent})
            print("mp3 list:", mp3FileNames)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
        let filePath = (FilePathConstants.directoryStringPath as NSString).stringByAppendingPathComponent(fileName)

        
        TakenPhotoView.image = LocalStoragePhotoManager.loadLocalImage(filePath)
    }
    
    
    @IBAction func previousImageButton(sender: AnyObject) {
    }
    
    
    @IBAction func nextImageButton(sender: AnyObject) {
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

