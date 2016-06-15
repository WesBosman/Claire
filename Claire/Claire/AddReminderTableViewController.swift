//
//  AddReminderTableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/7/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class AddReminderTableViewController: UITableViewController {
    @IBOutlet weak var reminderDatePicker: UIDatePicker!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var setTimeDetailLabel: UILabel!
    private let timeFormat = NSDateFormatter()
    private var timePickerHidden = false
    private var timePickerTitle = false
    private var reminderHour: Int = 0
    private var reminderMinute:Int = 0
    var hourMinuteDictionary: Dictionary<String, [Int]> = [:]
    var timeOneArray: [Int] = []
    var timeTwoArray:[Int] = []
    var timeThreeArray:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimeDetailLabel.text = "00:00"
        timeFormat.dateFormat = "HH:mm"
        reminderDatePicker.datePickerMode = UIDatePickerMode.CountDownTimer
        reminderSwitch.onTintColor = UIColor.purpleColor()
        reminderSwitch.tintColor = UIColor.purpleColor()
        reminderSwitch.setOn(false, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reminderSwitchPressed(sender: AnyObject) {
        togglePickerTitle()
    }
    
    func togglePickerTitle(){
        timePickerTitle = !timePickerTitle
        timePickerHidden = !timePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func calcTime(hour:Int, minute:Int, date: NSDate) -> [Int]{
        let calendar = NSCalendar.currentCalendar()
        let newDateComp = calendar.components([.Hour, .Minute], fromDate: date)
        let newHour = newDateComp.hour
        let newMinute = newDateComp.minute
//        print("New Hour: \(newHour)")
//        print("New Minute: \(newMinute)")
        
        var strHour = hour + newHour
        var strMinute = minute + newMinute
        if strMinute > 59{
            strHour = strHour + 1
            let newMinutes = strMinute - 60
            strMinute = newMinutes
//            print("Minutes greater than 60")
//            print("New Hour: \(strHour)")
//            print("New Minute: \(strMinute)")
            reminderHour = (strHour)
            reminderMinute = (strMinute)
        }
        else{
//            print("Hour: \(strHour)")
//            print("Minute: \(strMinute)")
            reminderHour = (strHour)
            reminderMinute = (strMinute)
        }
        if strHour > 12 {
            let newHour = strHour - 12
            strHour = newHour
//            print("Hour greater than 12")
//            print("New Hour: \(strHour)")
//            print("New Minute: \(strMinute)")
            reminderHour = (strHour)
            reminderMinute = (strMinute)
        }
        else{
//            print("Hour: \(strHour)")
//            print("Minute: \(strMinute)")
            reminderHour = (strHour)
            reminderMinute = (strMinute)
        }
        return [reminderHour, reminderMinute]
    }

    
    @IBAction func timePickerHasChanged(sender: AnyObject) {
        var hour = 0
        var minute = 0
        
        // Update the right detail text when the picker moves.
        let str = timeFormat.stringFromDate(reminderDatePicker.date)
        setTimeDetailLabel.text = str
        let date = timeFormat.dateFromString(str)!

        // get arrays for the times
        if let arrayForTimeOne = hourMinuteDictionary["Time One"]{
            hour = arrayForTimeOne[0]
            minute = arrayForTimeOne[1]
            timeOneArray = calcTime(hour, minute: minute, date: date)
//            print("Time One Hour: \(hour)")
//            print("Time One Minute: \(minute)")
//            print("Time One Array: \(timeOneArray)")
        }
        
        if let arrayForTimeTwo = hourMinuteDictionary["Time Two"]{
            hour = arrayForTimeTwo[0]
            minute = arrayForTimeTwo[1]
            timeTwoArray = calcTime(hour, minute: minute, date: date)
//            print("Time Two Hour: \(hour)")
//            print("Time Two Minute: \(minute)")
//            print("Time Two Array: \(timeTwoArray)")
        }
        
        if let arrayForTimeThree = hourMinuteDictionary["Time Three"]{
            hour = arrayForTimeThree[0]
            minute = arrayForTimeThree[1]
            timeThreeArray = calcTime(hour, minute: minute, date: date)
//            print("Time Three Hour: \(hour)")
//            print("Time Three Minute: \(minute)")
//            print("Time Three Array: \(timeThreeArray)")
        }

    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if !timePickerTitle && reminderSwitch.on == false
            && indexPath.section == 1 && indexPath.row == 0{
            return 0
        }
        else if !timePickerHidden && reminderSwitch.on == false
            && indexPath.section == 1 && indexPath.row == 1{
            return 0
        }
        else{
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "UnwindAddReminder" {
            print("Unwind from add reminder to table view controller")
            let destination = segue.destinationViewController as! TableViewController
            destination.reminderRightDetail.text = setTimeDetailLabel.text!
            destination.reminderHour = reminderHour
            destination.reminderMinute = reminderMinute
            destination.reminderOne = timeOneArray
            destination.reminderTwo = timeTwoArray
            destination.reminderThree = timeThreeArray
//            destination.viewWillAppear(true)
        }
    }

}
