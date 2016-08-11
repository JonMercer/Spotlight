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
    
    let windowWidth = UIScreen.mainScreen().bounds.width
    let windowHeight = UIScreen.mainScreen().bounds.height
    
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
    func populateImage(cellImage: UIImageView, index: Int)
    func collectionIndexSelected(index: NSIndexPath)
    func getNumberOfCellImages() -> Int
    func grabPhotoInfoKeysInBigGeoBlocks(completion: () -> ())
}

//MARK: - UICollectionViewDelegate
extension NearMeViewContainer: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate!.collectionIndexSelected(indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: gridView.frame.width * 0.33, height: gridView.frame.width * 0.33)
    }
}
//MARK: - UICollectionViewDataSource
extension NearMeViewContainer: UICollectionViewDataSource {
    
    //load this many cells
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: don't hardcore this
        // grab count of images in bigGeoBlock and neighbours
        return delegate!.getNumberOfCellImages()
    }
    
    //called when a cell has to be displayed
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellView = UINib(nibName: "NearMeViewContainerCell", bundle: nil)
        gridView.registerNib(cellView, forCellWithReuseIdentifier: "nearMeCell")
        let nearMeCell = self.gridView.dequeueReusableCellWithReuseIdentifier("nearMeCell", forIndexPath: indexPath) as! NearMeViewContainerCell
        
        nearMeCell.cellImage.image = nil
        
        delegate!.populateImage(nearMeCell.cellImage, index: indexPath.row)
        
        return nearMeCell

    }
}