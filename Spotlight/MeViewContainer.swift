//
//  MeViewContainer.swift
//  Spotlight
//
//  Created by Odin on 2016-08-16.
//  Copyright © 2016 SpotlightTeam. All rights reserved.
//


import UIKit

class MeViewContainer: UIView {
    var delegate: MeViewContainerDelegate?
    var cell: MeViewContainerCell?
    
    let windowWidth = UIScreen.mainScreen().bounds.width
    let windowHeight = UIScreen.mainScreen().bounds.height
    
    @IBOutlet var gridView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Log.debug("Me container is loaded")
    }
    
    //MARK: - Helper functions
    class func instanceFromNib(frame: CGRect) -> MeViewContainer {
        let view = UINib(nibName: "MeViewContainer", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! MeViewContainer
        view.frame = frame
        view.gridView.delegate = view
        view.gridView.dataSource = view
        view.gridView.backgroundColor = UIColor.whiteColor()
        return view
    }
}

//MARK: - NearMeViewContainerDelegate
protocol MeViewContainerDelegate {
    func populateImage(cellImage: UIImageView, index: Int)
    func collectionIndexSelected(index: NSIndexPath)
    func getNumberOfCellImages() -> Int
    func grabMyPhotoInfoKeys(completion: () -> ())
}

//MARK: - UICollectionViewDelegate
extension MeViewContainer: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate!.collectionIndexSelected(indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: gridView.frame.width * 0.33, height: gridView.frame.width * 0.33)
    }
}
//MARK: - UICollectionViewDataSource
extension MeViewContainer: UICollectionViewDataSource {
    
    //load this many cells
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: don't hardcore this
        // grab count of images in bigGeoBlock and neighbours
        return delegate!.getNumberOfCellImages()
    }
    
    //called when a cell has to be displayed
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //SL-191
        let cellView = UINib(nibName: "MeViewContainerCell", bundle: nil)
        gridView.registerNib(cellView, forCellWithReuseIdentifier: "meCell")
        let nearMeCell = self.gridView.dequeueReusableCellWithReuseIdentifier("meCell", forIndexPath: indexPath) as! MeViewContainerCell
        
        nearMeCell.cellImage.image = nil
        
        delegate!.populateImage(nearMeCell.cellImage, index: indexPath.row)
        
        return nearMeCell
    }
}
