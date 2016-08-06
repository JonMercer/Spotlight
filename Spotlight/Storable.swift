//
//  FirebaseStorage.swift
//  Spotlight
//
//  Created by Odin on 2016-07-10.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Photos

protocol Storable {
    func downloadPhotoByName(name: ImageName, completionHandler: (err: ErrorType, image: UIImage) -> ())
}