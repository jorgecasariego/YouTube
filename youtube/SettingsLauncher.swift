//
//  SettingsLauncher.swift
//  youtube
//
//  Created by Jorge Casariego on 29/8/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit

// Create this Model Object to save our cells name and image name of each item of settings
class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case Term = "Termns & Privacy policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight:CGFloat = 50
    
    let settings: [Setting]  = {
        let settingsSetting = Setting(name: .Settings, imageName: "settings")
        let termSetting = Setting(name: .Term, imageName: "privacy")
        let sendFeecbackSetting = Setting(name: .SendFeedback, imageName: "feedback")
        let helpSetting = Setting(name: .Help, imageName: "help")
        let switchAccountSetting = Setting(name: .SwitchAccount, imageName: "switch_account")
        let cancelSetting = Setting(name: .Cancel, imageName: "cancel")
        
        return [settingsSetting,
                termSetting,
                sendFeecbackSetting,
                helpSetting,
                switchAccountSetting,
                cancelSetting]
    }()
    
    var homeController: HomeController?
    
    func showSettings() {
        
        // To cover the entire app we need to do with the if
        if let window = UIApplication.sharedApplication().keyWindow {
            // Show menu
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRectMake(0, window.frame.height, window.frame.width, height)
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: { 
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRectMake(0, y, self.collectionView.frame.width, self.collectionView.frame.height)
                }, completion: nil)
        }
        
    }
    
    func handleDismiss(setting: Setting) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
            
            self.blackView.alpha = 0
            
            if let window = UIApplication.sharedApplication().keyWindow {
                self.collectionView.frame = CGRectMake(0, window.frame.height, window.frame.width, window.frame.height)
            }
            
            
        }) { (completed: Bool) in
            if setting.name != .Cancel {
                self.homeController?.showControllerForSetting(setting)
            }
            
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.width, 50)
    }
    
    //Reduce the space between cells
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    //Select item of setting
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let setting = settings[indexPath.item]
        handleDismiss(setting)
    }
    
    override init(){
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // We can use UICollectionViewCell.self but in our case we need a custom cell with a label and image, so we'll use SettingCell
        collectionView.registerClass(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}