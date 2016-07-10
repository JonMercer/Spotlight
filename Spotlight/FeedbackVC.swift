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
    print("Opened FeedbackVC")
    // Do any additional setup after loading the view, typically from a nib.
    
    setupViewContainer()
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
  
  
  //MARK: - Temporary Buttons
  @IBAction func signInButton(sender: AnyObject) {
    //MARK: Log in
    FIRAuth.auth()?.signInWithEmail("\(name)@g.com", password: "123456") { (user, error) in
      if (error != nil) {
        print("Could not log in creating a user:\(self.name)")
        
        //MAKR: Create a user
        FIRAuth.auth()?.createUserWithEmail("\(self.name)@g.com", password: "123456") { (user, error) in
          if (error != nil) {
            print("Could not create a user:\(self.name)")
          } else {
            print("Created a user:\(self.name)")
          }
        }
      } else {
        print("User:\(self.name) logged in")
      }
    }
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
      print("Printing \(self.name)'s message: \(messageFromFirebase)")
      
      // ...
    }) { (error) in
      print(error.localizedDescription)
    }
  }
}

extension FeedbackVC: FeedbackViewContainerDelegate {
  func plus5(num: Int) -> Int {
    print("input number is:\(num)")
    return num + 5
  }
    
    func storeAnImageInFIR(){
        //MARK: Write to FIR
        let ref = FIRDatabase.database().reference()
        if let user = FIRAuth.auth()?.currentUser {
            // User is signed in.
            ref.child("users").child(user.uid).setValue(["username": "\(user.email) made this"])
            print("user:\(user.email) created an entry")
        } else {
            print("user is not signed in.")
            // No user is signed in.
        }
        
        let storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL("gs://spotlight-5a0c3.appspot.com")
        
        let imageURL = LocalStoragePhotoManager.getImageURLsInDirectory().last!
        let imageName = LocalStoragePhotoManager.getImageNamesInDirectory().last!
        
        // YK commented out the following line-- doesn't seem to be doing anything.
//        let imageRef = storageRef.child(imageName)
        let spaceRef = storageRef.child("images/\(imageName).jpg")
        
        //Uploading Data
        //let imageData: NSData = UIImagePNGRepresentation(UIImage(named: "100by100")!)!
        
        // Upload the file to the path "images/<imageName>.jpg"
        let uploadTask = spaceRef.putFile(imageURL, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
                print("Error uploading image")
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL
                print("Image uploaded.")
//                print("Image uploaded at URL:\(downloadURL().debugDescription)")
            }
        }
    }
}

