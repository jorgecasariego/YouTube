//
//  ApiService.swift
//  youtube
//
//  Created by Jorge Casariego on 31/8/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: ([Video]) -> ()) {
        let url = "\(baseUrl)/home.json"
        
        fetchFeedForUrlString(url, completion: completion)
    }
    
    func fetchTrendingFeed(completion: ([Video]) -> ()) {
        let url = "\(baseUrl)/trending.json"
        
        fetchFeedForUrlString(url, completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: ([Video]) -> ()) {
        let url = "\(baseUrl)/subscriptions.json"
        
        fetchFeedForUrlString(url, completion: completion)
        
    }
    
    func fetchFeedForUrlString(urlString: String, completion: ([Video]) -> () ) {
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                if let unwrappedData = data, let jsonDictionaries = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: .MutableContainers) as? [[String: AnyObject]] {
                    
                    // Version 3
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                    })
                }
                
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
            }.resume()
    }

}

//  VERSION 2
//            let numberArray = [1,2,3]
//            let stringArray = numberArray.map({return "\($0 * 2)"})
//            print(stringArray)
//
//            var videos = [Video]()
//            for dictionary in jsonDictionaries {
//                let video = Video(dictionary: dictionary)
//                videos.append(video)
//            }


// VERSION 1
//        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//
//        var videos = [Video]()
//
//        for dictionary in json as! [[String: AnyObject]] {
//            let video = Video()
//            video.title = dictionary["title"] as? String
//            video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//            
//            
//            let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//            let channel = Channel()
//            channel.name = channelDictionary["name"] as? String
//            channel.profileImageName = channelDictionary["profile_image_name"] as? String
//            
//            video.channel = channel
//            
//            videos.append(video)
//        }
//        dispatch_async(dispatch_get_main_queue(), {
//            completion(videos)
//        })