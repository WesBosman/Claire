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
    // This interferes with selecting rows of the table view. Otherwise cool.
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    // This works fine
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class TableViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var dietSwitch: UISwitch!
    @IBOutlet weak var timeToTakeMedicineDatePicker: UIDatePicker!
    @IBOutlet weak var timeToTakeMedsRightDetail: UILabel!
    @IBOutlet weak var medicationNameTextBox: UITextField!
    @IBOutlet weak var numberOfTimesRightDetail: UILabel!
    @IBOutlet weak var repeatRightDetail: UILabel!
    @IBOutlet weak var reminderRightDetail: UILabel!
    @IBOutlet weak var timeAfterEatingDetail: UILabel!
    @IBOutlet weak var timeAfterEatingPicker: UIDatePicker!
    var timeAfterEatingFormat = NSDateFormatter()
    var timeAfterEatingTitleHidden = false
    var timeAfterEatingPickerHidden = false
    var medicationDaysSet: Set<String> = []
    var timesDictionary: Dictionary<String, String> = [:]
    var editName:String = ""
    var editingDays:String = ""
    var editRemember: String = ""
    var editTimes:String = ""
    var editDiet:String = ""
    var editDietSwitchOn:Bool = false
    var editingPreviousEntry = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        timeAfterEatingDetail.text = editDiet
        
        dietSwitch.tintColor = UIColor.purpleColor()
        dietSwitch.onTintColor = UIColor.purpleColor()
        dietSwitch.setOn(editDietSwitchOn, animated: true)
        timeAfterEatingFormat.dateFormat = "HH:mm"
        timeAfterEatingPicker.datePickerMode = UIDatePickerMode.CountDownTimer
        toggleTimeAfterEating()
        toggleTimeAfterEatingPicker()
        
        if editDietSwitchOn == true{
            toggleTimeAfterEating()
            toggleTimeAfterEatingPicker()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    }
    
    // Function for hiding the keyboard when the return key is pressed.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.barTintColor = UIColor.purpleColor()
        nav?.tintColor = UIColor.whiteColor()
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        if editingPreviousEntry == true{
            print("Editing Previous Entry")
        }
        
        // If the name and the times and repeat are not null then continue.
        if (!medicationNameTextBox.text!.isEmpty && !numberOfTimesRightDetail.text!.isEmpty
            //&& !timeAfterEatingDetail.text!.isEmpty 
            && !repeatRightDetail.text!.isEmpty
            //&& !reminderRightDetail.text!.isEmpty
            ){
            var medication = MedicationItem(name: medicationNameTextBox.text!,
                                            time: numberOfTimesRightDetail.text!,
                                            diet: timeAfterEatingDetail.text ?? "",
                                            days: repeatRightDetail.text!,
                                            reminder: reminderRightDetail.text ?? "",
                                            UUID: NSUUID().UUIDString)
            medication.setTimesDictionary(timesDictionary)
            medication.setDaysSet(medicationDaysSet)
            print("Times Dictionary: \(timesDictionary.keys) \(timesDictionary.values)")
//            print("Days Set: \(medicationDaysSet)")
//            print("Medication \(medication)")
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
        //print("Unwind action was called")
        tableView.reloadData()
    }
    
    @IBAction func waitAfterEatingChanged(sender: AnyObject) {
        let str = timeAfterEatingFormat.stringFromDate(timeAfterEatingPicker.date)
        timeAfterEatingDetail.text = str
    }

    @IBAction func dietAction(sender: AnyObject) {
        toggleTimeAfterEating()
        toggleTimeAfterEatingPicker()
    }
    
    func toggleTimeAfterEating(){
        timeAfterEatingTitleHidden = !timeAfterEatingTitleHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeAfterEatingPicker(){
        timeAfterEatingPickerHidden = !timeAfterEatingPickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Toggle the date picker for diet switch
        if indexPath.section == 2 && indexPath.row == 1{
            toggleTimeAfterEatingPicker()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // Hide the time after eating title
        if dietSwitch.on == false && timeAfterEatingTitleHidden
            && indexPath.section == 2 && indexPath.row == 1{
            return 0
        }
        // Hide the time after eating picker
        else if dietSwitch.on == false && timeAfterEatingPickerHidden
            && indexPath.section == 2 && indexPath.row == 2{
            return 0
        }
        // Hide the time after eating picker not based on the switch
        else if timeAfterEatingPickerHidden && indexPath.section == 2 && indexPath.row == 2{
            return 0
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveSegue"{
            saveButtonPressed(self)
        }
    }
}
