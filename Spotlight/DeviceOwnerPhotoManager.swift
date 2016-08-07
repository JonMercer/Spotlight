//
//  DeviceOwnerPhotoManager.swift
//  Spotlight
//
//  Created by Odin on 2016-06-28.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Photos

class DeviceOwnerPhotoManager {
    var imageIndex = 0
    
    var imagePathNames:[String] = []

    // TODO: handle if no if imagePathNames empty
    
    func getFirstImage() -> UIImage {
        return ModelInterface.sharedInstance.loadLocalImageByName(imagePathNames[0])
    }
    
    func nextImage() -> UIImage {
        if((imageIndex + 1) < imagePathNames.count) {
            imageIndex += 1
        }
        
        return ModelInterface.sharedInstance.loadLocalImageByName(imagePathNames[imageIndex])
    }
    
    func prevImage() -> UIImage {
        if((imageIndex - 1) >= 0) {
            imageIndex -= 1
        }
        
        return ModelInterface.sharedInstance.loadLocalImageByName(imagePathNames[imageIndex])
    }
    
    func updateImages() {
        //TODO check emptyness
        imagePathNames = ModelInterface.sharedInstance.getImageNamesInDirectory()
    }
    
}
