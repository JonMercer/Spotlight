//
//  NearMeViewContainer.swift
//  Spotlight
//
//  Created by Tanha Kabir on 2016-07-18.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//

import UIKit

class NearMeViewContainer: UIView {
    var delegate: NearMeViewContainerDelegate?
    
    @IBOutlet var gridView: UICollectionView!
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> NearMeViewContainer {
        let view = UINib(nibName: "NearMeViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! NearMeViewContainer
        view.frame = frame
        view.gridView.delegate = view
        view.gridView.dataSource = view
        view.gridView.backgroundColor = UIColor.whiteColor()
        return view
    }
}

//MARK: - NearMeViewContainerDelegate
protocol NearMeViewContainerDelegate {
}

//MARK: - UICollectionViewDelegate
extension NearMeViewContainer: UICollectionViewDelegate {
    //TODO: does this function belong in this extension?
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
}

//MARK: - UICollectionViewDataSource
extension NearMeViewContainer: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellView = UINib(nibName: "NearMeViewContainerCell", bundle: nil)
        gridView.registerNib(cellView, forCellWithReuseIdentifier: "nearMeCell")
        let nearMeCell = self.gridView.dequeueReusableCellWithReuseIdentifier("nearMeCell", forIndexPath: indexPath) as! NearMeViewContainerCell
        
        return nearMeCell

    }
}