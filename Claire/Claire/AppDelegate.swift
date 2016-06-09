//
//  AppDelegate.swift
//  Claire
//
//  Created by Wes Bosman on 6/2/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        return true
    }
    
    // If the user is already inside of the application the display an alert message
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        // Get the state of the application and if the app is running then display an alert message.
        let state: UIApplicationState = UIApplication.sharedApplication().applicationState
        var host = self.window?.rootViewController
        
        if state == UIApplicationState.Active{
            let alert: UIAlertController = UIAlertController(title: "Alert", message: "Time to take your medication", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                // Essentially do nothing. Unless we want to print some sort of log message.
            }))
            while let next = window?.inputViewController{
                host = next
            }
            host?.presentViewController(alert, animated: true, completion: nil)
        }
        // Post notification reset the icon badge number
        NSNotificationCenter.defaultCenter().postNotificationName("medicationList", object: self)
        application.applicationIconBadgeNumber = 0
        
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
        NSNotificationCenter.defaultCenter().postNotificationName("medicationList", object: self)
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0

    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

