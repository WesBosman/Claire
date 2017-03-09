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
    @IBOutlet weak var reminderSwitch:     UISwitch!
    @IBOutlet weak var setTimeDetailLabel: UILabel!
    fileprivate let timeFormat       = DateFormatter()
    fileprivate let fullFormat       = DateFormatter()
    fileprivate var timePickerHidden = false
    fileprivate var timePickerTitle  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullFormat.dateFormat = "MM/dd/yyyy h:mm:ss a"
        setTimeDetailLabel.text = "0:00"
        timeFormat.dateFormat   = "H:mm"
        reminderDatePicker.datePickerMode = UIDatePickerMode.countDownTimer
        reminderSwitch.onTintColor = UIColor.purple
        reminderSwitch.tintColor   = UIColor.purple
        reminderSwitch.setOn(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reminderSwitchPressed(_ sender: AnyObject) {
        togglePickerTitle()
    }
    
    func togglePickerTitle(){
        timePickerTitle = !timePickerTitle
        timePickerHidden = !timePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    // This method should only have to update the label
    @IBAction func timePickerHasChanged(_ sender: AnyObject) {
        // Update the right detail text when the picker moves.
        timeFormat.dateFormat = "H:mm"
        let str = timeFormat.string(from: reminderDatePicker.date)
        setTimeDetailLabel.text = str
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if !timePickerTitle && reminderSwitch.isOn == false
            && indexPath.section == 1
            && indexPath.row == 0{
            return 0
        }
        else if !timePickerHidden && reminderSwitch.isOn == false
            && indexPath.section == 1
            && indexPath.row == 1{
            return 0
        }
        else{
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        print("Segue Identifier : \(segue.identifier)")
        if segue.identifier == "UnwindAddReminder" {
            let destination = segue.destination as!MedicationStaticTableViewController
            
            // Create a calendar 
            let calendar = Calendar.autoupdatingCurrent
            
            if let timeOne = Globals.timesDictionary[Globals.timeOneKey]{
                // Create reminder for time one
                let date = reminderDatePicker.date
                let dateComp = calendar.dateComponents([.hour, .minute], from: date)
                let newDate = calendar.date(byAdding: dateComp, to: timeOne)
                print("Time One Alert -> \(fullFormat.string(from: newDate!))")
                Globals.reminderDictionary[Globals.reminderOneKey] = newDate!
            }
            if let timeTwo = Globals.timesDictionary[Globals.timeTwoKey]{
                // Create reminder for time two
                let date = reminderDatePicker.date
                let dateComp = calendar.dateComponents([.hour, .minute], from: date)
                let newDate = calendar.date(byAdding: dateComp, to: timeTwo)
                print("Time Two Alert -> \(fullFormat.string(from: newDate!))")
                Globals.reminderDictionary[Globals.reminderTwoKey] = newDate!
            }
            if let timeThree = Globals.timesDictionary[Globals.timeThreeKey]{
                let date = reminderDatePicker.date
                let dateComp = calendar.dateComponents([.hour, .minute], from: date)
                let newDate = calendar.date(byAdding: dateComp, to: timeThree)
                print("Time Three Alert -> \(fullFormat.string(from: newDate!))")
                Globals.reminderDictionary[Globals.reminderThreeKey] = newDate!
            }
            destination.reminderRightDetail.text = setTimeDetailLabel.text!
            print("Unwind add reminder")
        }
    }

}
