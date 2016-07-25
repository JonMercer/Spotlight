//
//  FeedbackVC.swift
//  Spotlight
//
//  Created by Odin on 2016-07-05.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps

class FeedbackVC: UIViewController {
    let name = "jojo"
    
    var container: FeedbackViewContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
        signIn()
        
        //fakeGeoBlocks()
        
        //TODO:delete this
//        getBigGeoBlockContent("000_000") { (listOfGeoBlockKeys) in
//            Log.debug(listOfGeoBlockKeys.debugDescription)
//            //
//            //        self.sortGeoBlocks(listOfGeoBlockKeys) { (sortedListOfGeoBlockKey) in
//            //            Log.debug("sorted block completion")
//            //        }
//            //
//        }
        //    self.sortGeoBlocks(["-1_-3", "1_2", "4_-5"], currentGeoBlockKey: "0_0") { (sortedListOfGeoBlockKey) in
        //        Log.debug(sortedListOfGeoBlockKey.description)
        //    }
        
        getNeighbouringBigGeoBlockContent("001_001") { (listOfGeoBlockKeys) in
            Log.debug(listOfGeoBlockKeys.description)
        }
        
    }
    
    func fakeGeoBlocks() {
        Log.debug("running")
        let firebaseRef = FIRDatabase.database().reference()
        
        for i in 0...30 {
            let lat = 0 + Double(i)/10
            let lon = 0 + Double(i)/10
            let geoBlockKey = GeoUtil.getGeoBlockKeyByLatLon(lat, lon: lon)
            let bigGeoBlockKey: String = GeoUtil.getBigGeoBlockKeyByLatLon(lat, lon: lon)
            
            let childUpdates = ["/BigGeoBlock/\(bigGeoBlockKey)/\(geoBlockKey)": 1,
                                "/GeoBlock/\(geoBlockKey)/\(i)": "dummy"]
            
            firebaseRef.updateChildValues(childUpdates, withCompletionBlock: {(error,ref) in
                if(error != nil) {
                    Log.error("Could not update geo block data")
                } 
            })
        }
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
    func testCompletion(completion: (result: String) -> Void){
        // I wanted to wait 5 seconds here, but it doesn't seem so simple to implement it.  No need to do it for now.
        completion(result: "test")
    }
    
    func signIn() {
        var name = self.name
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
        
        //        let imageURL = LocalStoragePhotoManager.getImageURLsInDirectory().last!
        //        ModelInterface.sharedInstance.uploadPhoto(imageURL, completionHandler: { (err) in
        //            //TODO: handle error properly
        //            print("ERROR: TODO handle this error")
        //        })
        
    }
    
    
}

extension FeedbackVC: BigGeoBlockEditor {
}

