//
//  MedicationItem.swift
//  Claire
//
//  Created by Wes Bosman on 6/7/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import Foundation
import RealmSwift

class MedicationDate: Object{
    dynamic var date: Date? = nil
}

class Medication: Object{
    dynamic var name: String             = String()
    dynamic var dosesPerDay: Int         = 0
    dynamic var timesSkipped: Int        = 0
    dynamic var timesTaken:   Int        = 0
    dynamic var timeOne: Date?           = nil
    dynamic var timeTwo: Date?           = nil
    dynamic var timeThree: Date?         = nil
    dynamic var reminderOne: Date?       = nil
    dynamic var reminderTwo: Date?       = nil
    dynamic var reminderThree: Date?     = nil
    dynamic var daysToTakeString: String = String()
    dynamic var notificationRepeatString = String()
    dynamic var uuid: String             = String()
    let datesToTake: List<MedicationDate>= List<MedicationDate>()
}
