//
//  MedicationItem.swift
//  Claire
//
//  Created by Wes Bosman on 6/7/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import Foundation

struct MedicationItem{
    var medicationName:String
    var medicationTimes:String
    var medicationDietTime:String?
    var medicationDays:String
    var reminderTime:String?
    var uuid:String
    var arrayOfDays:Set<String> = []
    var arrayOfTimes:Dictionary<String, String> = [:]
    
    init(name:String, time:String, diet: String?, days: String, reminder:String?, UUID:String){
        self.medicationName = name
        self.medicationTimes = time
        self.medicationDays = days
        self.medicationDietTime = diet ?? " "
        self.reminderTime = reminder ?? " "
        self.uuid = UUID
        self.arrayOfTimes = [:]
        self.arrayOfDays = []
    }
    
    mutating func setDaysSet(days:Set<String>){
        self.arrayOfDays = days
    }
    
    mutating func setTimesDictionary(times:Dictionary<String, String>){
        self.arrayOfTimes = times
    }
}