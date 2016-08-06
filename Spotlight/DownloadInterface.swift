//
//  DownloadInterface.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-08-06.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
import Firebase
import Photos

protocol DownloadInterfaceProtocol {
    func getPhotosNearMe()
    func getPhoto()
    func getMyPhotos()
}