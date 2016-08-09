//
//  CommunityInterface.swift
//  Spotlight
//
//  Created by Odin on 2016-08-08.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation


protocol CommunityInterfaceProtocol {
    func addComment()
    func thumbsUp()
    func undoThumbsUp()
    func deleteComment()
    func flag()
    func undoFlag()
}