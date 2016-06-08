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
    
    init(name:String, time:String, diet: String?, days: String, reminder:String?, UUID:String){
        self.medicationName = name
        self.medicationTimes = time
        self.medicationDays = days
        self.medicationDietTime = diet ?? " "
        self.reminderTime = reminder ?? " "
        self.uuid = UUID
    }
}