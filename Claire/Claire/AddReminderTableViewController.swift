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

    override func viewDidLoad() {
        super.viewDidLoad()
        setTimeDetailLabel.text = "0:00"
        timeFormat.dateFormat = "HH:mm "
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

    
    @IBAction func timePickerHasChanged(sender: AnyObject) {
        let str = timeFormat.stringFromDate(reminderDatePicker.date)
        setTimeDetailLabel.text = str
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
//        print("Segue Id: \(segue.identifier!)")
        if segue.identifier == "UnwindAddReminder" {
            let destination = segue.destinationViewController as! TableViewController
            destination.reminderRightDetail.text = setTimeDetailLabel.text!
            destination.viewWillAppear(true)
//            print("Set Time Label: \(setTimeDetailLabel.text!)")
        }
    }

}
