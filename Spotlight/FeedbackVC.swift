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
  let name = "joe"
  
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
    //MARK: Write to FIR
    let ref = FIRDatabase.database().reference()
    if let user = FIRAuth.auth()?.currentUser {
      // User is signed in.
      ref.child("users").child(user.uid).setValue(["username": "\(self.name) made this"])
      print("user:\(self.name) created an entry")
    } else {
      // No user is signed in.
    }
    
    let storage = FIRStorage.storage()
    let storageRef = storage.referenceForURL("gs://spotlight-5a0c3.appspot.com")
    
    let imageRef = storageRef.child("images")
    let spaceRef = storageRef.child("images/space.jpg")
    
    
    let imageData: NSData = UIImagePNGRepresentation(UIImage(named: "100by100")!)!
    
    // Upload the file to the path "images/space.jpg"
    let uploadTask = spaceRef.putData(imageData, metadata: nil) { metadata, error in
      if (error != nil) {
        // Uh-oh, an error occurred!
        print("Error uploading image")
      } else {
        // Metadata contains file metadata such as size, content-type, and download URL.
        let downloadURL = metadata!.downloadURL
        print("Image uploaded at URL:\(downloadURL)")
      }
    }
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
  override func viewDidLoad() {
    super.viewDidLoad()
    print("Opened FeedbackVC")
    // Do any additional setup after loading the view, typically from a nib.

    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

