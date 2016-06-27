//
//  CameraVC.swift
//  Spotlight
//
//  Created by Odin on 2016-06-26.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//


import UIKit

class CameraVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        // Convert PhotoView.image into a JPEG representation
        let imageJPEG = UIImageJPEGRepresentation(PhotoView.image!, 1.0)!
        let data = NSData(data: imageJPEG)
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
        let fileName = "test_path" // temporary file name for testing.  change this later.
        let path = (documentsDirectory as NSString).stringByAppendingPathComponent(fileName)
        let success = data.writeToFile(path, atomically: true)
        if !success { print ("Got some error writing to a file!!") }
        
        // The file is stored in the app's file system.  Now retrieve it and convert it back to an image.
        let dir = NSURL(fileURLWithPath: path)
        let retrievedData = NSData(contentsOfURL: dir)
        let retrievedImage = UIImage(data:retrievedData!)
        PhotoView2.image = retrievedImage
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        PhotoView.image = info [UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //photoAlbum.createAlbum()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

