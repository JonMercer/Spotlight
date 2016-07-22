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
    var cell: NearMeViewContainerCell?
    
    @IBOutlet var gridView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Log.debug("Near me container is loaded")
    }
    
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
    func populateImage(cellImage: UIImageView)
}

//MARK: - UICollectionViewDelegate
extension NearMeViewContainer: UICollectionViewDelegate {
    //TODO: does this function belong in this extension?
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}

//MARK: - UICollectionViewDataSource
extension NearMeViewContainer: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellView = UINib(nibName: "NearMeViewContainerCell", bundle: nil)
        gridView.registerNib(cellView, forCellWithReuseIdentifier: "nearMeCell")
        let nearMeCell = self.gridView.dequeueReusableCellWithReuseIdentifier("nearMeCell", forIndexPath: indexPath) as! NearMeViewContainerCell

        delegate!.populateImage(nearMeCell.cellImage)
        //cell = nearMeCell
        
        return nearMeCell

    }
}