//
//  Authenticate.swift
//  Spotlight
//
//  Created by Odin on 2016-07-10.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation

protocol Authenticate {
    
    func isUserSignedIn(completionHandler: (signedIn:Bool)-> ())
}