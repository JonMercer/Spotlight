//
//  PhotoVC.swift
//  Spotlight
//
//  Created by Odin on 2016-08-21.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class PhotoVC: UIViewController {
    
    var container: PhotoViewContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = PhotoViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PhotoVC: PhotoViewContainerDelegate {
    func simplePrint() {
        Log.test("printing the delegate")
    }
}
