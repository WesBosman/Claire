//
//  MedicationItemList.swift
//  Claire
//
//  Created by Wes Bosman on 6/7/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit
import RealmSwift

// Make this a singleton class
private let sharedMedicationInstance = MedicationList()

// Use this class to update Realm
class MedicationList {
    static let sharedInstance = sharedMedicationInstance
    
    // Add to database
    func addMedicationToDb(item: Medication){
        
        do{
            let realm = try Realm()
        
            try realm.write{
                realm.create(Medication.self, value: item, update: false)
            }
            
            // Set a notification for the medication
            setNotificationForMed(item: item)
            
        }catch let err as NSError{
            print("Error: Adding medication to db -> \(err.localizedDescription)")
        }
    }
    
    // Update the database
    func updateMedicationInDb(){
        
    }
    
    // Remove from the database
    func removeMedicationInDb(med: Medication){
        do{
            let realm = try Realm()
            if let medication = realm.objects(Medication.self).first(where: {($0.name == med.name)}){
                try realm.write{
                    realm.delete(medication)
                }
                // Remove the notification when we delete it from the db
                removeNotficationForMed(item: medication)
            }
        }
        catch let error as NSError{
            fatalError(error.localizedDescription)
        }
    }
    
    // Mark - Notification Methods
    
    func setNotificationForMed(item: Medication){
        let dateformat = DateFormatter()
        let calendar   = Calendar.current
        dateformat.dateFormat = "MMM d, yyyy h:mm:ss a"
        
        for medDate in item.datesToTake{
            print("MedDate -> \(medDate)")
            if let medicationDate = medDate.date{
                // Get the day month and year from the medicationDate
                var dayComp = calendar.dateComponents([.month, .day, .year], from: medicationDate)
                
                // Schedule the times
                if let timeOne = item.timeOne{
                    // Debug Print fire date
                    let timeOneComp = calendar.dateComponents([.hour, .minute], from: timeOne)
                    dayComp.hour = timeOneComp.hour
                    dayComp.minute = timeOneComp.minute
                    dayComp.second = 0
                    let newTimeOneDate = calendar.date(from: dayComp)!
                    print("New Time One Date \(dateformat.string(from: newTimeOneDate))")
                    // Create notification
                    notificationForMed(alertTitle: "First Dose",
                                       alertBody: "Time to take medication: \(item.name)",
                                       fireDate: newTimeOneDate,
                                       repeatInterval: item.notificationRepeatString,
                                       uuid: item.uuid)
                    
                }
                if let timeTwo = item.timeTwo{
                    // Debug print out the fire date
                    let timeTwoComp = calendar.dateComponents([.hour, .minute], from: timeTwo)
                    dayComp.hour = timeTwoComp.hour
                    dayComp.minute = timeTwoComp.minute
                    dayComp.second = 0
                    let newTimeTwoDate = calendar.date(from: dayComp)!
                    print("New Time Two Date \(dateformat.string(from: newTimeTwoDate))")
                    // Create notification
                    notificationForMed(alertTitle: "Second Dose",
                                       alertBody: "Time to take medication: \(item.name)",
                                       fireDate: newTimeTwoDate,
                                       repeatInterval: item.notificationRepeatString,
                                       uuid: item.uuid)
                    
                }
                if let timeThree = item.timeThree{
                    // Debug print out the fire date
                    let timeThreeComp = calendar.dateComponents([.hour, .minute], from: timeThree)
                    dayComp.hour = timeThreeComp.hour
                    dayComp.minute = timeThreeComp.minute
                    dayComp.second = 0
                    let newTimeThreeDate = calendar.date(from: dayComp)!
                    print("New Time One Date \(dateformat.string(from: newTimeThreeDate))")
                    
                    // Create notification
                    notificationForMed(alertTitle: "Third Dose",
                                       alertBody: "Time to take medication: \(item.name)",
                                       fireDate: newTimeThreeDate,
                                       repeatInterval: item.notificationRepeatString,
                                       uuid: item.uuid)
                }
                // Schedule the reminders
                if let reminderOne = item.reminderOne{
                    let reminderOneComp = calendar.dateComponents([.hour, .minute], from: reminderOne)
                    dayComp.hour = reminderOneComp.hour
                    dayComp.minute = reminderOneComp.minute
                    dayComp.second = 0
                    let newReminderOneDate = calendar.date(from: dayComp)!
                    print("New Reminder One Date \(dateformat.string(from: newReminderOneDate))")
                    
                    notificationForMed(alertTitle: "Reminder One",
                                       alertBody: "Reminder To Take Medication \(item.name)",
                                       fireDate: newReminderOneDate,
                                       repeatInterval: item.notificationRepeatString,
                                       uuid: item.uuid)
                }
                if let reminderTwo = item.reminderTwo{
                    let reminderTwoComp = calendar.dateComponents([.hour, .minute], from: reminderTwo)
                    dayComp.hour = reminderTwoComp.hour
                    dayComp.minute = reminderTwoComp.minute
                    dayComp.second = 0
                    let newReminderTwoDate = calendar.date(from: dayComp)!
                    print("New Reminder One Date \(dateformat.string(from: newReminderTwoDate))")
                    
                    notificationForMed(alertTitle: "Reminder Two",
                                       alertBody: "Reminder To Take Medication \(item.name)",
                        fireDate: newReminderTwoDate,
                        repeatInterval: item.notificationRepeatString,
                        uuid: item.uuid)
                }
                if let reminderThree = item.reminderThree{
                    let reminderThreeComp = calendar.dateComponents([.hour, .minute], from: reminderThree)
                    dayComp.hour = reminderThreeComp.hour
                    dayComp.minute = reminderThreeComp.minute
                    dayComp.second = 0
                    let newReminderThreeDate = calendar.date(from: dayComp)!
                    print("New Reminder One Date \(dateformat.string(from: newReminderThreeDate))")
                    
                    notificationForMed(alertTitle: "Reminder Three",
                                       alertBody: "Reminder To Take Medication \(item.name)",
                                       fireDate: newReminderThreeDate,
                                       repeatInterval: item.notificationRepeatString,
                                       uuid: item.uuid)
                }
            }
        }
    }
    
    func notificationForMed(alertTitle: String,
                            alertBody: String,
                            fireDate: Date,
                            repeatInterval: String,
                            uuid: String){
        
        let notification = UILocalNotification()
        notification.alertTitle  = alertTitle
        notification.alertBody   = alertBody
        notification.fireDate    = fireDate
        notification.alertAction = "Open"
        notification.soundName   = UILocalNotificationDefaultSoundName
        notification.userInfo    = ["uuid": uuid]
        
        switch(repeatInterval){
            case "None":
                break
            case "Daily":
                notification.repeatInterval  = .day
            case "Weekly":
                notification.repeatInterval  = .weekOfYear
            case "Monthly:":
                notification.repeatInterval  = .month
            case "Yearly":
                notification.repeatInterval  = .year
            default:
                break
            
        }
        
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    func removeNotficationForMed(item: Medication){
        
        if let scheduledNotifications = UIApplication.shared.scheduledLocalNotifications{
            for notification in scheduledNotifications{
                print("Notification in local notifications")
                print("Notification UUID = \(notification.userInfo?["uuid"])")
                // If the notification uuid equals the uuid passed in then delete the notification
                if let uuid = notification.userInfo?["uuid"] as? String{
                    if uuid == item.uuid{
                        // Delete the notification
                        UIApplication.shared.cancelLocalNotification(notification)
                        print("Canceling notification with the title \(notification.alertTitle)")
                    }
                }
            }
        }
    }
    
}
