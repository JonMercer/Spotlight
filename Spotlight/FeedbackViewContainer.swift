//
//  FeedbackView.swift
//  Spotlight
//
//  Created by Odin on 2016-07-07.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit


class FeedbackViewContainer: UIView {

  @IBAction func button(sender: AnyObject) {
    print("\nbutton pressed")
  }
  
  class func instanceFromNib(frame: CGRect) -> FeedbackViewContainer {
    let view = UINib(nibName: "FeedbackViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! FeedbackViewContainer
    view.frame = frame
    return view
  }
}