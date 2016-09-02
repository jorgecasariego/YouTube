//
//  FeedCell.swift
//  youtube
//
//  Created by Jorge Casariego on 31/8/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    
    var videos: [Video]?
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        fetchVideos()
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.registerClass(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    // Add number of items
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos?.count ?? 0
        
    }
    
    // Implement this function to return a cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Every time we call dequeueReusableCellWithReuseIdentifier, it is calling setupView(frame) in VideoCell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        
        //  To see something we add some color
        //  cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
    
    // After conform to UICollectionViewDelegateFlowLayout we implement sizeForItemAtIndexPath
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9 / 16
        return CGSizeMake(frame.width, height + 16 + 88)
    }
    
    // To control spaces between cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }


}
