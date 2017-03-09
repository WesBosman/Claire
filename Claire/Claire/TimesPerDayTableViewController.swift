//
//  TimesPerDayTableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/4/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class TimesPerDayTableViewController: UITableViewController {
    
    @IBOutlet weak var timeOneDatePicker : UIDatePicker!
    @IBOutlet weak var timeTwoDatePicker : UIDatePicker!
    fileprivate var timeOneTitleIsHidden    = false
    fileprivate var timeTwoTitleIsHidden    = false
    fileprivate var timeThreeTitleIsHidden  = false
    fileprivate var timePickerOneIsHidden   = false
    fileprivate var timePickerTwoIsHidden   = false
    fileprivate var timePickerThreeIsHidden = false
    @IBOutlet weak var timeThreeDatePicker:  UIDatePicker!
    @IBOutlet weak var timeOneDetailLabel:   UILabel!
    @IBOutlet weak var timeTwoDetailLabel:   UILabel!
    @IBOutlet weak var timeThreeDetailLabel: UILabel!
    let timeFormat:           DateFormatter = DateFormatter()
    var newTimeDictionary:    Dictionary<String, Date> = [:]
    let dateFormat = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Toggle time pickers
        toggleTimeOneTitle()
        toggleTimeTwoTitle()
        toggleTimeThreeTitle()
        toggleTimeOnePicker()
        toggleTimeTwoPicker()
        toggleTimeThreePicker()
        
        // Set the datepicker modes to time
        timeOneDatePicker.datePickerMode   = UIDatePickerMode.time
        timeTwoDatePicker.datePickerMode   = UIDatePickerMode.time
        timeThreeDatePicker.datePickerMode = UIDatePickerMode.time
        
        timeOneDetailLabel.text   = String()
        timeTwoDetailLabel.text   = String()
        timeThreeDetailLabel.text = String()
        
        // Set date pickers to initial values
        timeFormat.dateFormat = "h:mm a"
        let defaultStartTime  = timeFormat.date(from: "7:00 AM")
        timeOneDatePicker.date   = defaultStartTime!
        timeTwoDatePicker.date   = defaultStartTime!
        timeThreeDatePicker.date = defaultStartTime!
        
    }
    
    func toggleTimeOneTitle(){
        timeOneTitleIsHidden = !timeOneTitleIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeTwoTitle(){
        timeTwoTitleIsHidden = !timeTwoTitleIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeThreeTitle(){
        timeThreeTitleIsHidden = !timeThreeTitleIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeOnePicker(){
        timePickerOneIsHidden = !timePickerOneIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeTwoPicker(){
        timePickerTwoIsHidden = !timePickerTwoIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeThreePicker(){
        timePickerThreeIsHidden = !timePickerThreeIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func timeOneDatePickerAction(_ sender: AnyObject) {
        timeOneDatePickerChanged()
    }

    @IBAction func timeTwoDatePickerAction(_ sender: AnyObject) {
        timeTwoDatePickerChanged()
    }

    @IBAction func timeThreeDatePickerAction(_ sender: AnyObject) {
        timeThreeDatePickerChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if timePickerOneIsHidden
            && indexPath.section == 1
            && indexPath.row == 1{
            return 0
        }
        else if timeOneTitleIsHidden
            && indexPath.section == 1
            && indexPath.row == 0{
            return 0
        }
        else if timePickerTwoIsHidden
            && indexPath.section == 1
            && indexPath.row == 3{
            return 0
        }
        else if timeTwoTitleIsHidden
            && indexPath.section == 1
            && indexPath.row == 2{
            return 0
        }
        else if timePickerThreeIsHidden
            && indexPath.section == 1
            && indexPath.row == 5{
            return 0
        }
        else if timeThreeTitleIsHidden
            && indexPath.section == 1
            && indexPath.row == 4{
            return 0
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    // Had a problem where the user has to rotate the picker because a date can not be formed from 
    // Just the string 7:00 AM
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0
            && (indexPath.row == 0
                || indexPath.row == 1
                || indexPath.row == 2){
            // Toggle checkmark
            toggleCheckmark(tableView, indexPath: indexPath)
            
            if indexPath.row == 0{
                toggleTimeOneTitle()
                timeOneDetailLabel.text = "7:00 AM"
            }
            else if indexPath.row == 1{
                toggleTimeTwoTitle()
                timeTwoDetailLabel.text = "7:00 AM"
            }
            else if indexPath.row == 2{
                toggleTimeThreeTitle()
                timeThreeDetailLabel.text = "7:00 AM"
            }
        }
        else if indexPath.section == 1
            &&  indexPath.row == 0{
            toggleTimeOnePicker()
        }
        else if indexPath.section == 1
            &&  indexPath.row == 2{
            toggleTimeTwoPicker()
        }
        else if indexPath.section == 1
            &&  indexPath.row == 4{
            toggleTimeThreePicker()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Toggle the checkmarks on the time cells
    func toggleCheckmark(_ tableView: UITableView, indexPath: IndexPath){
        // Get a cell and change the accessory type to a checkmark when clicked
        let selection = tableView.cellForRow(at: indexPath)
        if let selectedCell = selection{
            if(selectedCell.accessoryType == .checkmark){
                selectedCell.accessoryType = .none
            }
            else{
                selectedCell.accessoryType = .checkmark
            }
        }
    }
    
    func generateNewDate(_ date: Date) -> Date{
        let calendar = Calendar.current
        let todayComponents = calendar
                                .dateComponents([.month, .day, .year],
                                                from: Date())
        var dateComponents = calendar.dateComponents([.hour, .minute],
                                                     from: date)
        dateComponents.day   = todayComponents.day
        dateComponents.month = todayComponents.month
        dateComponents.year  = todayComponents.year
        dateFormat.dateFormat = "MM/dd/yyyy h:mm:ss a"
        let newDate = calendar.date(from: dateComponents)
        let newDateAsString = dateFormat.string(from: newDate!)
        print("New generated date -> \(newDateAsString)")
        return newDate!
    }
    
    func timeOneDatePickerChanged(){
        let timeOneDate = generateNewDate(timeOneDatePicker.date)
        newTimeDictionary[Globals.timeOneKey] = timeOneDate
        let str = timeFormat.string(from: timeOneDatePicker.date)
        timeOneDetailLabel.text = str
    }
    
    func timeTwoDatePickerChanged(){
        let timeTwoDate = generateNewDate(timeTwoDatePicker.date)
        newTimeDictionary[Globals.timeTwoKey] = timeTwoDate
        let str = timeFormat.string(from: timeTwoDatePicker.date)
        timeTwoDetailLabel.text = str
    }
    
    func timeThreeDatePickerChanged(){
        let timeThreeDate = generateNewDate(timeThreeDatePicker.date)
        newTimeDictionary[Globals.timeThreeKey] = timeThreeDate
        let str = timeFormat.string(from: timeThreeDatePicker.date)
        timeThreeDetailLabel.text = str
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "UnwindTimesPerDay"{
            let destination = segue.destination as! MedicationStaticTableViewController
            var times:String = String()
            
            // Time One
            if let timeOne = timeOneDetailLabel.text{
                times += timeOne + " "
                
                if let timeOneDate = newTimeDictionary[Globals.timeOneKey]{
                    print("Time Three Date -> \(timeOneDate)")
                    Globals.timesDictionary[Globals.timeOneKey] = timeOneDate
                }
            }
            // Time Two
            if let timeTwo = timeTwoDetailLabel.text{
                times += timeTwo + " "
                
                if let timeTwoDate = newTimeDictionary[Globals.timeTwoKey]{
                    print("Time Two Date -> \(timeTwoDate)")
                    Globals.timesDictionary[Globals.timeTwoKey] = timeTwoDate
                }
            }
            // Time Three
            if let timeThree = timeThreeDetailLabel.text{
                times += timeThree
                
                if let timeThreeDate = newTimeDictionary[Globals.timeThreeKey]{
                    print("Time Three Date -> \(timeThreeDate)")
                    Globals.timesDictionary[Globals.timeThreeKey] = timeThreeDate
                }
            }
            
            // Trim the whitespaces before sending the string back
            destination.numberOfTimesRightDetail.text = times.trimmingCharacters(in: .whitespaces)
        }
    }
}
