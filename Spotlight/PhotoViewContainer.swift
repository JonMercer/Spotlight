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
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageDescription: UITextView!
    
    @IBAction func backButton(sender: AnyObject) {
        delegate?.goBackToGridView()
    }
    
    @IBAction func mapButtonPressed(sender: AnyObject) {
        delegate?.goToMapView()
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
    
    func loadImage(withImage: UIImage) {
        self.image.image = withImage
    }
    
    func loadDescription(withDescription: Description) {
        imageDescription.text = withDescription
    }

}

protocol PhotoViewContainerDelegate {
    func goBackToGridView()
    func goToMapView()
}
