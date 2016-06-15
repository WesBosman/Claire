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
    var medicationDays:String
    var reminderOne: [Int]
    var reminderTwo: [Int]
    var reminderThree: [Int]
    var uuid:String
    var listOfDays:[String] = []
    var dictionaryOfTimes:Dictionary<String, String> = [:]
    
    init(name:String, time:String, days: String, reminderOne:[Int], reminderTwo:[Int], reminderThree: [Int], UUID:String){
        self.medicationName = name
        self.medicationTimes = time
        self.medicationDays = days
        self.reminderOne = reminderOne
        self.reminderTwo = reminderTwo
        self.reminderThree = reminderThree
        self.uuid = UUID
        self.dictionaryOfTimes = [:]
        self.listOfDays = []
    }
    
    mutating func setDaysSet(days:[String]){
        self.listOfDays = days
    }
    
    mutating func setTimesDictionary(times:Dictionary<String, String>){
        self.dictionaryOfTimes = times
    }
}