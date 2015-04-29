//
//  AppDelegate.swift
//  Wayfarer-ios
//
//  Created by Ryan Pillsbury on 2/22/15.
//  Copyright (c) 2015 Ryan Pillsbury. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var Context: WaysContext!
    static var userId: Int!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        var UUID = getOrCreateUUID();
        AppDelegate.userId = UUID.0;
        AppDelegate.Context = DataImporter().importData(AppDelegate.userId);
        if (Globals.prefetchThumbnailsOnAppLoad) {
            self.prefetchThumbnails();
        }
        
        return true
    }
    
    // Returns a uuid. Also returns true user already existed, and false otherwise
    private func getOrCreateUUID() -> (Int, Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var UUIDObject: AnyObject? = userDefaults.objectForKey("ApplicationUniqueIdentifier");
        if UUIDObject == nil {
            var user = WayAPI.createNewUser()
            var UUID = user!.id!
            userDefaults.setObject(UUID, forKey: "ApplicationUniqueIdentifier")
            userDefaults.synchronize()
            return (UUID, false);
        } else {
            return ((UUIDObject as! Int), true);
        }
    
    }
    
    private func prefetchThumbnails() {
        for way in AppDelegate.Context!.Ways {
            way.fetchImage(is2x: false, isAsync: false, callback: nil);
        }
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

