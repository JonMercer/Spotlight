//
//  NearMeVC.swift
//  Spotlight
//
//  Created by Odin on 2016-07-18.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class NearMeVC: UIViewController {
    var container: NearMeViewContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContainer()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Helper Functions
    private func setupViewContainer() {
        container = NearMeViewContainer.instanceFromNib(
            CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        container?.delegate = self
        view.addSubview(container!)
    }
}

//MARK: - NearMeViewContainerDelegate
extension NearMeVC: NearMeViewContainerDelegate {
    func populateImage(cellImage: UIImageView, index: Int) {
        grabKeysOfAllEntities { (photoEntityKeys) in
            if(index >= photoEntityKeys.count) {
                //TODO: if we reach, we grab more pics
                cellImage.image = UIImage()
            } else {
                self.getPhotoEntity(photoEntityKeys[index], completion: { (photoEntity) in
                    ModelInterface.sharedInstance.downloadPhotoByName(photoEntity.getPhotoName()) { (err, image) in
                        cellImage.image = image
                    }
                })
            }
        }
    }
}

//MARK: - PhotoEntities
extension NearMeVC: PhotoEntities {
    
}

//MARK: - PhotoEntityEditor
extension NearMeVC: PhotoEntityEditor {
    
}
