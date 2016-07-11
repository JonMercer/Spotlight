//
//  FeedbackView.swift
//  Spotlight
//
//  Created by Odin on 2016-07-07.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

protocol FeedbackViewContainerDelegate {
  func signIn()
  func storeAnImageInFIR()
}

class FeedbackViewContainer: UIView {
  
  var delegate: FeedbackViewContainerDelegate?
    
  @IBAction func button(sender: AnyObject) {
    //print("\nSigning in a user...")
    //delegate?.signIn()
    //print("\nSigning in a user... DONE")
    
    delegate?.storeAnImageInFIR()
  }
  
  class func instanceFromNib(frame: CGRect) -> FeedbackViewContainer {
    let view = UINib(nibName: "FeedbackViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! FeedbackViewContainer
    view.frame = frame
    return view
  }
}