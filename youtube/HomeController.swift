//
//  ViewController.swift
//  youtube
//
//  Created by Jorge Casariego on 24/8/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit

// Step 3: Change UIVIewController to UICollectionViewController and rename Controller
// Step 10: To change width and height of cell we have to conform to UICollectionViewDelegateFlowLayout
class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Step 5: Add a title
        navigationItem.title = "Home"
        navigationController?.navigationBar.translucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleLabel
        
        
        
        // Step 2
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        // Step 8: We need to register cellId to use with cell
        //collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        // Step 13: Now we call the new VideoCell
        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
    
    //Step 6: Add number of items 
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // Step 7: implement this function to return a cell
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Every time we call dequeueReusableCellWithReuseIdentifier, it is calling setupView(frame) in VideoCell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath)
        
        // Step 9: to see something we add some color 
        //cell.backgroundColor = UIColor.redColor()
        
        return cell
    }
    
    // Step 11: after conform to UICollectionViewDelegateFlowLayout we implement sizeForItemAtIndexPath
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSizeMake(view.frame.width, height + 16 + 68)
    }
    
    // To control spaces between cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

}




