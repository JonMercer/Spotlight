//
//  FeedbackView.swift
//  Spotlight
//
//  Created by Odin on 2016-07-07.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

protocol FeedbackViewContainerDelegate {
  func plus5(num:Int) -> Int
}

class FeedbackViewContainer: UIView {
  
  var delegate: FeedbackViewContainerDelegate?

  @IBAction func button(sender: AnyObject) {
    print("\nbutton pressed")
    let num = delegate?.plus5(12)
    print("output number is:\(num)")
  }
  
  class func instanceFromNib(frame: CGRect) -> FeedbackViewContainer {
    let view = UINib(nibName: "FeedbackViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! FeedbackViewContainer
    view.frame = frame
    return view
  }
}