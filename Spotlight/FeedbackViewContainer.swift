//
//  FeedbackView.swift
//  Spotlight
//
//  Created by Odin on 2016-07-07.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

protocol FeedbackViewContainerDelegate {
  func testCompletion(completion: (result: String) -> Void)
  func signIn()
  func storeAnImageInFIR()
}

class FeedbackViewContainer: UIView {
  
  var delegate: FeedbackViewContainerDelegate?
    
  @IBAction func button(sender: AnyObject) {
    //print("\nSigning in a user...")
    //delegate?.signIn()
    //print("\nSigning in a user... DONE")
    
    // testing completion handler here.
    // basically, it says "run the function testCompletion", and when it's finished, print the result.
    delegate?.testCompletion(){
        (result: String) in
          print("done!")
          print(result)
    }
    
    delegate?.storeAnImageInFIR()
  }
  
  class func instanceFromNib(frame: CGRect) -> FeedbackViewContainer {
    
    let view = UINib(nibName: "FeedbackViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! FeedbackViewContainer
    view.frame = frame
    return view
  }
}