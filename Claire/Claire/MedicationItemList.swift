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
    
    // Create notifications for tasks??? They aren't really associated with time.
    // Add item to the dictionary
    func addItem(item: MedicationItem){
        // Create the dictionary object to hold my objects
        var medDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(MED_KEY) ?? Dictionary()
        medDictionary[item.uuid] = ["name" : item.medicationName,
                                    "times" : item.medicationTimes,
                                    "diet" : item.medicationDietTime ?? "",
                                    "days" : item.medicationDays ?? "",
                                    "reminder" : item.reminderTime!,
                                    "UUID" : item.uuid]
        
        // Save or Overwrite information in the dictionary
        NSUserDefaults.standardUserDefaults().setObject(medDictionary, forKey: MED_KEY)
        // Do not think I need to create a local notification.
    }
    
    // Function to remove items from the dictionary
    func removeItem(item: MedicationItem){
        // Do not think I need a notification deletion here but maybe
        
        if var meds = NSUserDefaults.standardUserDefaults().dictionaryForKey(MED_KEY){
            meds.removeValueForKey(item.uuid)
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
