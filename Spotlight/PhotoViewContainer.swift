//
//  PhotoView.swift
//  Spotlight
//
//  Created by Odin on 2016-08-21.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class PhotoViewContainer: UIView {
    var delegate: PhotoViewContainerDelegate?
    
    @IBAction func button(sender: AnyObject) {
        delegate?.simplePrint()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        Log.debug("Photo view container is loaded")
    }
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> PhotoViewContainer {
        let view = UINib(nibName: "PhotoViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! PhotoViewContainer
        view.frame = frame
        return view
    }

}

protocol PhotoViewContainerDelegate {
    func simplePrint()
}
