//
//  SubscriptionCell.swift
//  youtube
//
//  Created by Jorge Casariego on 1/9/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
