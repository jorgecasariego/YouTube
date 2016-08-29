//
//  Extensions.swift
//  youtube
//
//  Created by Jorge Casariego on 25/8/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
 
extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for(index, view) in views.enumerate() {
            let key = "v\(index)"
            
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageCache = NSCache()

class CustomImageView: UIImageView {
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = NSURL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.objectForKey(urlString) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                let imageToCache = UIImage(data: data!)
                
                // Esto hacemos para que no cargue otra imagen que no sea la correcta
                // Usado para imagenes muy pesadas
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString)
                
                
            })
        }).resume()
    }
}
