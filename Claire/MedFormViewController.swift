//
//  FormViewController.swift
//  Claire
//
//  Created by Wes Bosman on 1/24/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.


import UIKit
import Eureka

class MedFormViewController: FormViewController{
    let nameTag     = "Medication Name"
    let reminderTag = "Reminder Date"
    let repeatTag   = "Repeat"
    let alertTag    = "Alert"
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        form  = Section("Medication")
            <<< TextRow(){
                row in
                row.title = nameTag
                row.placeholder = "Name"
                row.tag = nameTag
        }
        +++ Section("Reminder Date")
            <<< DateTimeInlineRow(){
                row in
                row.title = reminderTag
                row.value = Date()
                row.tag   = reminderTag
        }
        +++ Section("Repeat Certain Days")
            <<< MultipleSelectorRow<String>(){
                $0.title   = repeatTag
                $0.options = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
                $0.tag = repeatTag
        }
        +++ Section("Alert Before Reminder")
//            +++ SwitchRow{
            
            
            <<< CountDownInlineRow{
                row in
                row.title = alertTag
                row.tag = alertTag
                }
                .cellUpdate({ cell, row in
                    row.value = Date()
                })
                .cellSetup({cell, row in
                    row.value = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
                    row.updateCell()
                    cell.update()
                })
//        }
        
        
        let nameRow = form.rowBy(tag: nameTag)
        let reminder = form.rowBy(tag: reminderTag)
        let repeatDays = form.rowBy(tag: repeatTag)
        let alertRow     = form.rowBy(tag: alertTag)
        
        let name = nameRow?.baseValue
        let remind = reminder?.baseValue
        let repeating = repeatDays?.baseValue
        let alert = alertRow?.baseValue
        
        print("Name   : \(name)")
        print("Remind : \(remind)")
        print("Repeat : \(repeating)")
        print("Alert  : \(alert)")
    }
    
}
