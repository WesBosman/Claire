//
//  AppDelegate.swift
//  Claire
//
//  Created by Wes Bosman on 6/2/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit
import RealmSwift
import BRYXBanner
import FontAwesome_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // Find the realm path
        if let dbPath = Realm.Configuration.defaultConfiguration.fileURL{
            print("Realm DB -> \(dbPath)")
        }
        
        // For Testing purposes only
        //UIApplication.shared.cancelAllLocalNotifications()
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        
        return true
    }
    
    // If the user is already inside of the application the display an alert message
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        print("Did receive a local notification")
        print("Notification Title \(notification.alertTitle)")
        // Use BRYX Banners for in app notifications
        let banner = Banner()
//        let bell = UIImage.fontAwesomeIcon(.bell, textColor: UIColor.orange, size: CGSize(width: 35, height: 35))
        banner.animationDuration = 4
//        banner.imageView.image = bell
        banner.backgroundColor = UIColor.orange
        banner.textColor = UIColor.white
        banner.titleLabel.text = notification.alertTitle
        banner.detailLabel.text = notification.alertBody
        banner.show()
        
        // Post notification reset the icon badge number
        NotificationCenter.default.post(name: Notification.Name(rawValue: "medicationList"), object: self)
        application.applicationIconBadgeNumber = 0
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        NotificationCenter.default.post(name: Notification.Name(rawValue: "medicationList"), object: self)
        UIApplication.shared.applicationIconBadgeNumber = 0

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

