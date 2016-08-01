//
//  UploadInterface.swift
//  Spotlight
//
//  Created by Odin on 2016-07-31.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Photos

protocol UploadInterfaceProtocol {
    func uploadPhoto(photo: Photo, completed: (err: ErrorType?) -> ())
    func uploadPhotoInfo(photo: Photo, completed: (err: ErrorType?) -> ())
}

extension ModelInterface: UploadInterfaceProtocol {
    func uploadPhoto(photo: Photo, completed: (err: ErrorType?) -> ()) {
        //upload image
        
        //add the imageName to photoInfo
    }
    
    func uploadPhotoInfo(photo: Photo, completed: (err: ErrorType?) -> ()) {
        //save the info to database
    }
}