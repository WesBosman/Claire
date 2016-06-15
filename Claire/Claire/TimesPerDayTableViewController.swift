//
//  TimesPerDayTableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/4/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class TimesPerDayTableViewController: UITableViewController {
    @IBOutlet weak var timeOneDatePicker: UIDatePicker!
    @IBOutlet weak var timeTwoDatePicker: UIDatePicker!
    private var timeOneTitleIsHidden = false
    private var timeTwoTitleIsHidden = false
    private var timeThreeTitleIsHidden = false
    private var timePickerOneIsHidden = false
    private var timePickerTwoIsHidden = false
    private var timePickerThreeIsHidden = false
    private var daysSelected = []
    @IBOutlet weak var timeThreeDatePicker: UIDatePicker!
    let timeFormat: NSDateFormatter = NSDateFormatter()
    @IBOutlet weak var timeOneDetailLabel: UILabel!
    @IBOutlet weak var timeTwoDetailLabel: UILabel!
    @IBOutlet weak var timeThreeDetailLabel: UILabel!
    var timeDictionary: Dictionary<String, String> = [:]
    var hourMinuteDictionary: Dictionary<String, [Int]> = [:]

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
        timeOneDatePicker.datePickerMode = UIDatePickerMode.Time
        timeTwoDatePicker.datePickerMode = UIDatePickerMode.Time
        timeThreeDatePicker.datePickerMode = UIDatePickerMode.Time
        
        timeOneDetailLabel.text = ""
        timeTwoDetailLabel.text = ""
        timeThreeDetailLabel.text = ""
        
        // Set date pickers to initial values
        timeFormat.dateFormat = "h:mm a"
        let defaultStartTime = timeFormat.dateFromString("7:00 AM")
        timeOneDatePicker.date = defaultStartTime!
        timeTwoDatePicker.date = defaultStartTime!
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
    
    @IBAction func timeOneDatePickerAction(sender: AnyObject) {
        timeOneDatePickerChanged()
    }

    @IBAction func timeTwoDatePickerAction(sender: AnyObject) {
        timeTwoDatePickerChanged()
    }

    @IBAction func timeThreeDatePickerAction(sender: AnyObject) {
        timeThreeDatePickerChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if timePickerOneIsHidden && indexPath.section == 1 && indexPath.row == 1{
            return 0
        }
        else if timeOneTitleIsHidden && indexPath.section == 1 && indexPath.row == 0{
            return 0
        }
        else if timePickerTwoIsHidden && indexPath.section == 1 && indexPath.row == 3{
            return 0
        }
        else if timeTwoTitleIsHidden && indexPath.section == 1 && indexPath.row == 2{
            return 0
        }
        else if timePickerThreeIsHidden && indexPath.section == 1 && indexPath.row == 5{
            return 0
        }
        else if timeThreeTitleIsHidden && indexPath.section == 1 && indexPath.row == 4{
            return 0
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    // Had a problem where the user has to rotate the picker because a date can not be formed from 
    // Just the string 7:00 AM
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2){
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
        else if indexPath.section == 1 && indexPath.row == 0{
            toggleTimeOnePicker()
        }
        else if indexPath.section == 1 && indexPath.row == 2{
            toggleTimeTwoPicker()
        }
        else if indexPath.section == 1 && indexPath.row == 4{
            toggleTimeThreePicker()
        }
        else{
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func toggleCheckmark(tableView: UITableView, indexPath: NSIndexPath){
        // Get a cell and change the accessory type
        let selection = tableView.cellForRowAtIndexPath(indexPath)
        
        if selection?.accessoryType == UITableViewCellAccessoryType.None{
            selection?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else{
            selection?.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    func timeComponents(date: NSDate) -> NSDateComponents{
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = calendar.components([.Hour, .Minute], fromDate: date)
        return dateComponents
    }
    
    func timeOneDatePickerChanged(){
        let timeOneComponents = timeComponents(timeOneDatePicker.date)
        hourMinuteDictionary["Time One"] = [timeOneComponents.hour, timeOneComponents.minute]
        let str = timeFormat.stringFromDate(timeOneDatePicker.date)
        timeOneDetailLabel.text = str
    }
    
    func timeTwoDatePickerChanged(){
        let timeTwoComponents = timeComponents(timeTwoDatePicker.date)
        hourMinuteDictionary["Time Two"] = [timeTwoComponents.hour, timeTwoComponents.minute]
        let str = timeFormat.stringFromDate(timeTwoDatePicker.date)
        timeTwoDetailLabel.text = str
    }
    
    func timeThreeDatePickerChanged(){
        let timeThreeComponents = timeComponents(timeThreeDatePicker.date)
        hourMinuteDictionary["Time Three"] = [timeThreeComponents.hour, timeThreeComponents.minute]
        let str = timeFormat.stringFromDate(timeThreeDatePicker.date)
        timeThreeDetailLabel.text = str
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier! == "UnwindTimesPerDay"{
            let destination = segue.destinationViewController as! TableViewController
            var times:String = ""
            if (!timeOneDetailLabel.text!.isEmpty){
                times += timeOneDetailLabel.text! + " "
                timeDictionary["timeOne"] = timeOneDetailLabel.text!
            }
            if (!timeTwoDetailLabel.text!.isEmpty){
                times += timeTwoDetailLabel.text! + " "
                timeDictionary["timeTwo"] = timeTwoDetailLabel.text!
            }
            if (!timeThreeDetailLabel.text!.isEmpty){
                times += timeThreeDetailLabel.text!
                timeDictionary["timeThree"] = timeThreeDetailLabel.text!
            }
            
            destination.numberOfTimesRightDetail.text = times
            destination.timesDictionary = timeDictionary
            destination.hourMinuteDictionary = hourMinuteDictionary
        }
    }
}
