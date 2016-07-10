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
  func plus5(num:Int) -> Int
  func storeAnImageInFIR()
}

class FeedbackViewContainer: UIView {
  
  var delegate: FeedbackViewContainerDelegate?
    
  @IBAction func button(sender: AnyObject) {
    print("\nbutton pressed")
    let num = delegate?.plus5(12)
    print("output number is:\(num)")

    print("\nSigning in a user...")
    delegate?.signIn()
    print("\nSigning in a user... DONE")
    
    print("\nStoring an image in FIR (Firebase)...")
    delegate?.storeAnImageInFIR()
    print("\nStoring an image in FIR (Firebase)... DONE (Hopefully)")
  }
  
  class func instanceFromNib(frame: CGRect) -> FeedbackViewContainer {
    let view = UINib(nibName: "FeedbackViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! FeedbackViewContainer
    view.frame = frame
    return view
  }
}