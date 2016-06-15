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
        // Do not think I need UUID's for these objects since I do not expect the names to ever be the same.
        var medDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(MED_KEY) ?? Dictionary()
        medDictionary[item.medicationName] = ["name" : item.medicationName,
                                    "times" : item.medicationTimes,
//                                    "diet" : item.medicationDietTime ?? "",
                                    "days" : item.medicationDays ?? "",
                                    "reminderOne" : item.reminderOne,
                                    "reminderTwo" : item.reminderTwo,
                                    "reminderThree":item.reminderThree,
                                    "UUID" : item.uuid]
        
        // Save or Overwrite information in the dictionary
        NSUserDefaults.standardUserDefaults().setObject(medDictionary, forKey: MED_KEY)
        // Start setting up the notiications.
        setNotificationTimes(item)
        
    }
    
    func setReminderNotifications(item: MedicationItem, date: NSDate, morningOrNight: String){
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([.Month, .Day, . Year, .Hour, .Minute], fromDate: date)
        let dateMonth = dateComponents.month
        let dateDay = dateComponents.day
        let dateYear = dateComponents.year
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM dd yyyy hh:mm a"
        var dateString:String = ""
//        var reminderDateArray:[NSDate] = []
        
        if !(item.reminderOne.isEmpty){
            let reminderOneHour = item.reminderOne[0]
            let reminderOneMinute = item.reminderOne[1]
            dateString = String(dateMonth) + " " + String(dateDay) + " " + String(dateYear) + " " + String(reminderOneHour) + ":" + String(reminderOneMinute) + " " + morningOrNight
            let reminderOneDate = formatter.dateFromString(dateString)!
//            print("Reminder One")
            print("Reminder One Date \(reminderOneDate)")
//            reminderDateArray.append(reminderOneDate)
            makeNotification(reminderOneDate, item: item, message: "Reminder to take medication \(item.medicationName)", category: "REMINDER_CATEGORY")
        }
        if !(item.reminderTwo.isEmpty){
            let reminderTwoHour = item.reminderTwo[0]
            let reminderTwoMinute = item.reminderTwo[1]
            dateString = String(dateMonth) + " " + String(dateDay) + " " + String(dateYear) + " " + String(reminderTwoHour) + ":" + String(reminderTwoMinute) + " " + morningOrNight
            let reminderTwoDate = formatter.dateFromString(dateString)!
//            print("Reminder Two ")
            print("REminder Two Date: \(reminderTwoDate)")
//            reminderDateArray.append(reminderTwoDate)
            makeNotification(reminderTwoDate, item: item, message: "Reminder to take medication \(item.medicationName)", category: "REMINDER_CATEGORY")
        }
        if !(item.reminderThree.isEmpty){
            let reminderThreeHour = item.reminderThree[0]
            let reminderThreeMinute = item.reminderThree[1]
            dateString = String(dateMonth) + " " + String(dateDay) + " " + String(dateYear) + " " + String(reminderThreeHour) + ":" + String(reminderThreeMinute) + " " + morningOrNight
            let reminderThreeDate = formatter.dateFromString(dateString)!
//            print("Reminder Three ")
            print("Reminder Three Date: \(reminderThreeDate)")
//            reminderDateArray.append(reminderThreeDate)
            makeNotification(reminderThreeDate, item: item, message: "Reminder to take medication \(item.medicationName)", category: "REMINDER_CATEGORY")
        }
    }
    
    func setNotificationTimes(item: MedicationItem){
        // Set up the dates and formating for the initial notifications.
        var newDate: String
//        var newDateArray = [NSDate]()
        let format = NSDateFormatter()
        format.dateFormat = "EEEE MMMM dd yyyy hh:mm a"
        
        for day in item.listOfDays{
            for time in item.dictionaryOfTimes.values{
                newDate = day + " " + time
                let newNSDate = format.dateFromString(newDate)
//                newDateArray.append(newNSDate!)
                if time.hasSuffix("PM"){
                    setReminderNotifications(item, date: newNSDate!, morningOrNight: "PM")
                }
                else{
                    setReminderNotifications(item, date: newNSDate!, morningOrNight: "AM")
                }
                makeNotification(newNSDate!, item: item, message: "Time to take Medication \(item.medicationName)", category: "MEDICATION_CATEGORY")
                
            }
        }
    }
    
    // Make the notification and set the category and message
    func makeNotification(day: NSDate, item: MedicationItem, message:String, category:String){
        let notification = UILocalNotification()
        notification.timeZone = NSTimeZone.localTimeZone()
        notification.repeatInterval = NSCalendarUnit.WeekOfYear
        notification.alertBody = message
        notification.applicationIconBadgeNumber = 1
        notification.alertAction = "open"
        notification.fireDate = day
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["NotificationUUID": item.medicationName]
        notification.category = category
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    // Function to remove items from the dictionary
    func removeItem(item: MedicationItem){

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
//        print("Medication Items \(medItems)")
        
        return medItems.map({MedicationItem(
            name: $0["name"] as! String,
            time: $0["times"] as! String,
            days: $0["days"] as! String,
            reminderOne: $0["reminderOne"] as! [Int],
            reminderTwo: $0["reminderTwo"] as! [Int],
            reminderThree: $0 ["reminderThree"] as! [Int],
            UUID: $0["UUID"] as! String
            )})
            .sort({(left: MedicationItem, right: MedicationItem) -> Bool in (left.medicationName.compare(right.medicationName) == .OrderedAscending)})
    }
}
