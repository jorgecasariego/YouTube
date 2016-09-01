//
//  TrendingCell.swift
//  youtube
//
//  Created by Jorge Casariego on 31/8/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
