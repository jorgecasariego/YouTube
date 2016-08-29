//
//  Video.swift
//  youtube
//
//  Created by Jorge Casariego on 29/8/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel? 
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
    
}
