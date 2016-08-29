//
//  AppDelegate.swift
//  youtube
//
//  Created by Jorge Casariego on 24/8/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Step 1
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        
        // Create a UICollectionViewLayout and pass to HomeController
        let layout = UICollectionViewFlowLayout()
        window?.rootViewController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        
        UINavigationBar.appearance().barTintColor = UIColor.rgb(230, green: 32, blue: 32)
        application.statusBarStyle = .LightContent
        
        // get rid of black bar underneath navbar
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
        
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor.rgb(194, green: 31, blue: 31)
        
        window?.addSubview(statusBarBackgroundView)
        window?.addConstraintsWithFormat("H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintsWithFormat("V:|[v0(20)]", views: statusBarBackgroundView)
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

