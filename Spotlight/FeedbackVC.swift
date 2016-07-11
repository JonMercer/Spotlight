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
  let name = "tantan"
  
  var container: FeedbackViewContainer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewContainer()
    signIn()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: Helper Functions
  private func setupViewContainer() {
    //TODO: use generic to avoid copy paste here
    container = FeedbackViewContainer.instanceFromNib(
      CGRectMake(0, 0, view.bounds.width, view.bounds.height))
    container?.delegate = self
    view.addSubview(container!)
  }
  
  @IBAction func sendAnItemButton(sender: AnyObject) {

  }
  
  @IBAction func printTextFromFirebase(sender: AnyObject) {
    //MARK: Read from FIR
    let ref = FIRDatabase.database().reference()
    let userID = FIRAuth.auth()?.currentUser?.uid
    ref.child("users").child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
      // Get user value
      let messageFromFirebase = snapshot.value!["username"] as! String
      //let user = User.init(username: username)
      print("Printing \(FIRAuth.auth()?.currentUser?.email)'s message: \(messageFromFirebase)")
      
      // ...
    }) { (error) in
      print(error.localizedDescription)
    }
  }
}

extension FeedbackVC: FeedbackViewContainerDelegate {
    func signIn() {
        var name = "tantan"
        //MARK: Log in
        FIRAuth.auth()?.signInWithEmail("\(name)@g.com", password: "123456") { (user, error) in
            if (error != nil) {
                print("Could not log in creating a user:\(name)")
                
                //MARK: Create a user
                FIRAuth.auth()?.createUserWithEmail("\(self.name)@g.com", password: "123456") { (user, error) in
                    if (error != nil) {
                        print("Could not create a user:\(name)")
                    } else {
                        print("Created a user:\(name)")
                    }
                }
            } else {
                print("User:\(name) logged in")
            }
        }
    }
    
    func storeAnImageInFIR(){
        let imageURL = LocalStoragePhotoManager.getImageURLsInDirectory().last!
        ModelInterface.sharedInstance.uploadPhoto(imageURL, completionHandler: { (err) in
            //TODO: handle error properly
            print("ERROR: TODO handle this error")
        })

    }
}

