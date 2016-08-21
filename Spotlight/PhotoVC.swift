//
//  PhotoVC.swift
//  Spotlight
//
//  Created by Odin on 2016-08-21.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {
    var photoInfoKey: PhotoInfoKey?
    
    var container: PhotoViewContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
        
        guard photoInfoKey != nil else {
            Log.error("photo info key should have been set on segue")
            return
        }
        
        ModelInterface.sharedInstance.downloadPhoto(photoInfoKey!) { (photo, err) in
            guard err == nil else {
                Log.error(err.debugDescription)
                return
            }
            
            guard photo != nil else {
                Log.error("photo should have been downloaded already")
                return
            }
            
            self.container?.loadImage((photo?.photoImage)!)
            self.container?.loadDescription((photo?.photoInfo?.description)!)
        }
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = PhotoViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
    
    func setKey(key: PhotoInfoKey) {
        self.photoInfoKey = key
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PhotoVC: PhotoViewContainerDelegate {
    func goBackToGridView() {
        performSegueWithIdentifier(Segues.toGridView, sender: self)
    }
}
