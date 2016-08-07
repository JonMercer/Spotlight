//
//  ModelInterface.swift
//  Spotlight
//
//  Created by Odin on 2016-07-10.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import Foundation
/**
 All controllers must use this class to get get and set data along with find out where to segue to next.
 
 Do the following to use the class: Modelinterface.sharedInstance.<functionName>
 
 See *ModelProtocol.swift files for functions supported by ModelInterface.
 */
class ModelInterface {
  static let sharedInstance = ModelInterface()
}



protocol EditInterfaceProtocol {
    func editPhotoDescription()
    func editComment()
}

protocol CommunityInterfaceProtocol {
    func addComment()
    func thumbsUp()
    func undoThumbsUp()
    func deleteComment()
    func flag()
    func undoFlag()
}

protocol DeletionInterfaceProtocol {
    func deletePhoto()
    func deleteUser()
}


//extension ModelInterface:  {
//    func uploadPhoto(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
//}
