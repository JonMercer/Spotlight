//
//  LoadingVC.swift
//  Spotlight
//
//  Created by Odin on 2016-07-26.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.sharedInstance.startGettingLoc()

        // play ad every 5 minutes
        NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(LoadingVC.goToTabView), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func goToTabView() {
        performSegueWithIdentifier(Segues.toTabView, sender: self)
    }

}
