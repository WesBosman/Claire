//
//  MedicationItemList.swift
//  Claire
//
//  Created by Wes Bosman on 6/7/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit
// Global singleton declaration so this class can be instantiated only once
private let sharedMedicationList = MedicationItemList()

class MedicationItemList{
    private let MED_KEY = "medItems"
    // New singleton code
    static let sharedInstance = sharedMedicationList
    
    // Add item to the dictionary
    func addItem(item: MedicationItem){
        // Create the dictionary object to hold my objects
        var medDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(MED_KEY) ?? Dictionary()
        medDictionary[item.medicationName] = ["name" : item.medicationName,
                                    "times" : item.medicationTimes,
                                    "diet" : item.medicationDietTime ?? "",
                                    "days" : item.medicationDays ?? "",
                                    "reminder" : item.reminderTime!,
                                    "UUID" : item.uuid]
        
        // Save or Overwrite information in the dictionary
        NSUserDefaults.standardUserDefaults().setObject(medDictionary, forKey: MED_KEY)
        // Make a notiication.
        setNotificationTimes(item)
        
    }
    
    func setNotificationTimes(item: MedicationItem){
        // Set up the dates and formating for the notifications.
        var newDate: String
        var newDateArray = [NSDate]()
        let format = NSDateFormatter()
        format.dateFormat = "EEEE MMMM dd yyyy hh:mm a"
        
        for day in item.arrayOfDays{
            for time in item.arrayOfTimes.values{
                newDate = day + " " + time
                let newNSDate = format.dateFromString(newDate)
                print("New NSDate: \(newNSDate)")
                newDateArray.append(newNSDate!)
                print("New Date Array: \(newDateArray)")
            }
        }
        
        var notificationArray = [UILocalNotification()]
//        var count: Int = 0
        
        for newDay in newDateArray{
//            count += 1
            print("New Day: \(newDay)")
            let notification = UILocalNotification()
            notification.timeZone = NSTimeZone.localTimeZone()
            notification.repeatInterval = NSCalendarUnit.WeekOfYear
            notification.alertBody = "Time to take medication \(item.medicationName)"
            notification.applicationIconBadgeNumber = 1
            notification.alertAction = "open"
            notification.fireDate = newDay
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.userInfo = ["NotificationUUID": item.uuid]
            notification.category = "MEDICATION_CATEGORY"
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            notificationArray.append(notification)
        }
    }
    
    // Function to remove items from the dictionary
    func removeItem(item: MedicationItem){
        // Do not think I need a notification deletion here but maybe
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications!{
            if notification.userInfo!["NotificationUUID"] as! String == item.medicationName{
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break
            }
        }
        if var meds = NSUserDefaults.standardUserDefaults().dictionaryForKey(MED_KEY){
            meds.removeValueForKey(item.medicationName)
            // Save item
            NSUserDefaults.standardUserDefaults().setObject(meds, forKey: MED_KEY)
        }
    }
    
    // Return items for the user to see in the table view
    func allMeds() -> [MedicationItem] {
        let medDict = NSUserDefaults.standardUserDefaults().dictionaryForKey(MED_KEY) ?? [:]
        let medItems = Array(medDict.values)
        print("Medication Items \(medItems)")
        return medItems.map({MedicationItem(
            name: $0["name"] as! String,
            time: $0["times"] as! String,
            diet: $0["diet"] as? String ?? "",
            days: $0["days"] as! String,
            reminder: $0["reminder"] as? String ?? "",
            UUID: $0["UUID"] as! String
            )})
            .sort({(left: MedicationItem, right: MedicationItem) -> Bool in (left.medicationName.compare(right.medicationName) == .OrderedAscending)})
    }
}
