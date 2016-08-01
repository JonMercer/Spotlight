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
    func uploadPhoto()
}

extension ModelInterface: UploadInterfaceProtocol {
    func uploadPhoto(image: UIImage, completionHandler: (err: ErrorType) -> ()) {
        //dfef
    }
}