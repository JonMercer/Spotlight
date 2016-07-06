//
//  FeedbackVC.swift
//  Spotlight
//
//  Created by Odin on 2016-07-05.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit
import Firebase

class FeedbackVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("Opened FeedbackVC")
    // Do any additional setup after loading the view, typically from a nib.
    
    //Firebase required authenticated users
    FIRAuth.auth()?.createUserWithEmail("jane2@g.com", password: "123456") { (user, error) in
      if (error != nil) {
        print("\nCould not log in")
      } else {
        print("\nUser logged in")
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

