//
//  TableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/2/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

//  Found this extension on stack overflow from Esqarrouth
extension UITableViewController {
    // This works fine
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class MedicationStaticTableViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var timeToTakeMedicineDatePicker: UIDatePicker!
    @IBOutlet weak var timeToTakeMedsRightDetail: UILabel!
    @IBOutlet weak var medicationNameTextBox: UITextField!
    @IBOutlet weak var numberOfTimesRightDetail: UILabel!
    @IBOutlet weak var repeatRightDetail: UILabel!
    @IBOutlet weak var reminderRightDetail: UILabel!
    var medicationDaysList:[String] = []
    var timesDictionary: Dictionary<String, String> = [:]
    var hourMinuteDictionary: Dictionary<String, [Int]> = [:]
    var editName:String = ""
    var editingDays:String = ""
    var editRemember: String = ""
    var editTimes:String = ""
    var editingPreviousEntry = false
    var editingMedication:MedicationItem? = nil
    var reminderHour:Int = 0
    var reminderMinute: Int = 0
    var reminderOne:[Int] = []
    var reminderTwo: [Int] = []
    var reminderThree:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle text field events.
        medicationNameTextBox.delegate = self
        
        // if edit name is empty then set a placeholder
        if editName.isEmpty{
            medicationNameTextBox.placeholder = "Name of Medication"
        }
        // Otherwise set the previous value
        else{
            medicationNameTextBox.text = editName
        }
        numberOfTimesRightDetail.text = editTimes
        reminderRightDetail.text = editRemember
        repeatRightDetail.text = editingDays
    }
    
    // Function for hiding the keyboard when the return key is pressed.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("Text Field Should Return Method was entered")
        self.medicationNameTextBox.resignFirstResponder()
        return true
    }
    
    // Set the color and style of the navigation bar.
    override func viewDidAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.barTintColor = UIColor.purpleColor()
        nav?.tintColor = UIColor.whiteColor()
    }
    
    // Save the medication item.
    @IBAction func saveButtonPressed(sender: AnyObject) {
        // Do not want to make two of the same medications with different unique identifiers.
        if editingPreviousEntry == true{
            print("Editing Previous Entry")
            if let editing = editingMedication{
                var medication = MedicationItem(name: medicationNameTextBox.text!,
                                                time: numberOfTimesRightDetail.text!,
                                                days: repeatRightDetail.text!,
                                                reminderOne: reminderOne,
                                                reminderTwo: reminderTwo,
                                                reminderThree: reminderThree,
                                                UUID: editing.uuid )
                medication.setTimesDictionary(timesDictionary)
                medication.setDaysSet(medicationDaysList)
                MedicationItemList.sharedInstance.addItem(medication)
            }
        }
        
        // If the name and the times and repeat are not null then continue.
        else if (!medicationNameTextBox.text!.isEmpty
              && !numberOfTimesRightDetail.text!.isEmpty
              && !repeatRightDetail.text!.isEmpty
            ){
            var medication = MedicationItem(name: medicationNameTextBox.text!,
                                            time: numberOfTimesRightDetail.text!,
                                            days: repeatRightDetail.text!,
                                            reminderOne: reminderOne,
                                            reminderTwo: reminderTwo,
                                            reminderThree: reminderThree,
                                            UUID: NSUUID().UUIDString)
            medication.setTimesDictionary(timesDictionary)
            medication.setDaysSet(medicationDaysList)
            MedicationItemList.sharedInstance.addItem(medication)
            
        }
        else{
            let alert:UIAlertController = UIAlertController(title: "Missing A Field", message: "One or more of the reqired fields marked with an asterisk has not been filled in", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                // Essentially do nothing. Unless we want to print some sort of log message.
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveSegue"{
            print("Save Segue")
            saveButtonPressed(self)
            
        }
        else if segue.identifier == "addReminderSegue"{
            print("Add Reminder Segue Taken")
            let destination = segue.destinationViewController as! AddReminderTableViewController
            if !timesDictionary.isEmpty{
                destination.hourMinuteDictionary = hourMinuteDictionary
                destination.timesDictionary = timesDictionary
                
                print("Times Dictionary keys: \(timesDictionary.keys)")
                print("Times Dictionary values: \(timesDictionary.values)")
                
                print("HourMinuteDictionary: \(hourMinuteDictionary.keys) values: \(hourMinuteDictionary.values)")
            }
            else if editingPreviousEntry == true {
//                let timesArray = editTimes.componentsSeparatedByString(" ")

//                timesDictionary["timeOne"] = timesArray[0] + " " + timesArray[1]
//                timesDictionary["timeTwo"] = (timesArray[2] + " " + timesArray[3]) ?? ""
//                timesDictionary["timeThree"] = (timesArray[4] + " " + timesArray[5]) ?? ""
                print("Times Dictionary keys: \(timesDictionary.keys)")
                print("Times Dictionary values: \(timesDictionary.values)")
                
            }
        }
    }
}
