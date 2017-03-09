//
//  TableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/2/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit
import RealmSwift

// Globals structure elements for holding data and dictionary keys
struct Globals{
    static var timesDictionary:    [String: Date] = [:]
    static var reminderDictionary: [String: Date] = [:]
    static let timeOneKey          = "timeOne"
    static let timeTwoKey          = "timeTwo"
    static let timeThreeKey        = "timeThree"
    static let reminderOneKey      = "reminderOne"
    static let reminderTwoKey      = "reminderTwo"
    static let reminderThreeKey    = "reminderThree"
    static var selectedDates:      [Date] = []
    static var notificationRepeatArray = ["None", "Daily", "Weekly", "Monthly", "Yearly"]
    static var selectedInterval:String = String()
}


//  Found this varension on stack overflow from Esqarrouth
extension UITableViewController {
    // This works fine
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

class MedicationStaticTableViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var medicationNameTextBox: UITextField!
    @IBOutlet weak var numberOfTimesRightDetail: UILabel!
    @IBOutlet weak var repeatRightDetail: UILabel!
    @IBOutlet weak var reminderRightDetail: UILabel!
    @IBOutlet weak var dosesStepper: UIStepper!
    @IBOutlet weak var numberOfDosesLabel: UILabel!
    @IBOutlet weak var intervalRightDetailLabel: UILabel!
    
    var medicationDaysList:   [String] = []
    var editName:             String = String()
    var editingDays:          String = String()
    var editRemember:         String = String()
    var editTimes:            String = String()
    var editingPreviousEntry: Bool   = false
    var hideReminderCell             = true
    let dateFormat                   = DateFormatter()
    
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
        numberOfDosesLabel.text = "1"
        dateFormat.dateFormat = "MM/dd/yyyy h:mm:ss a"
        
    }
    
    // Function for hiding the keyboard when the return key is pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Text Field Should Return Method was entered")
        self.medicationNameTextBox.resignFirstResponder()
        return true
    }
    
    // Set the color and style of the navigation bar.
    override func viewDidAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.barTintColor = UIColor.purple
        nav?.tintColor = UIColor.white
    }
    
    // Stepper did change action
    @IBAction func stepperDidChange(_ sender: Any) {
        print("Doses stepper changed -> \(dosesStepper.value)")
        numberOfDosesLabel.text = String(Int(dosesStepper.value))
    }
    
    
    // Save the medication item.
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        // Do not want to make two of the same medications with different unique identifiers.
        if editingPreviousEntry == true{
            print("Editing Previous Entry")
        
        
        }
        
        // If the name and the times and repeat are not null then continue.
        else if let name = medicationNameTextBox.text,
                let times = numberOfTimesRightDetail.text,
                let rep   = repeatRightDetail.text,
                let inval = intervalRightDetailLabel.text{

            print("Creating new medication item")
            print("Times -> \(times)")
            
            let med = Medication()
            med.name = name
            med.timeOne = Globals.timesDictionary[Globals.timeOneKey]
            med.timeTwo = Globals.timesDictionary[Globals.timeTwoKey]
            med.timeThree = Globals.timesDictionary[Globals.timeThreeKey]
            med.reminderOne = Globals.reminderDictionary[Globals.reminderOneKey]
            med.reminderTwo = Globals.reminderDictionary[Globals.reminderTwoKey]
            med.reminderThree = Globals.reminderDictionary[Globals.reminderThreeKey]
            med.daysToTakeString = rep
            med.notificationRepeatString = inval
            med.dosesPerDay = Int(dosesStepper.value)
            med.uuid = UUID().uuidString
            
            // Add the medication dates to the database
            for medDate in Globals.selectedDates{
                let medicationDate = MedicationDate()
                medicationDate.date = medDate
                med.datesToTake.append(medicationDate)
            }
            
            // Add the medication item to the database
            MedicationList.sharedInstance.addMedicationToDb(item: med)
            
            _ = self.navigationController?.popViewController(animated: true)
        }
        else{
            let alert:UIAlertController = UIAlertController(title: "Missing A Field", message: "One or more of the reqired fields marked with an asterisk has not been filled in", preferredStyle: .alert)
            
            let ok:UIAlertAction = UIAlertAction(title: "Dismiss",
                style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func unwindFromIntervalSelection(_ unwindSegue: UIStoryboardSegue){
        print("Unwind segue from calendar")
        if let destination = unwindSegue.destination as? MedicationStaticTableViewController{
            destination.intervalRightDetailLabel.text = Globals.selectedInterval
        }
    }
    
    @IBAction func unwindFromCalendar(_ unwindSegue: UIStoryboardSegue){
        print("Unwind segue from calendar")

        if let destination = unwindSegue.destination as? MedicationStaticTableViewController{
            print("Adding the selected dates to the medication static table view  controller")
            
            if let startDate = Globals.selectedDates.first,
                 let endDate = Globals.selectedDates.last{
            
                dateFormat.dateFormat = "EEEE"
            
                if startDate.compare(endDate) == .orderedSame{
                    let dateString = dateFormat.string(from: startDate)
                    destination.repeatRightDetail.text = dateString
                }
                else{
                    let startDateString = dateFormat.string(from: startDate)
                    let endDateString = dateFormat.string(from: endDate)
                    destination.repeatRightDetail.text = "\(startDateString) - \(endDateString)"
                }
            }
        }
    }
    
    @IBAction func myUnwindAction(_ unwindSegue: UIStoryboardSegue){
        print("Unwind segue was activated")
        if let identifier = unwindSegue.identifier{
            print("Unwind Segue Identifier = \(identifier)")
            if identifier == "UnwindTimesPerDay" && repeatRightDetail.text != nil{
                // Want to unhide the reminder cell
                hideReminderCell = false
            }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if hideReminderCell &&
            indexPath.section == 4 &&
            indexPath.row == 0{
            return 0
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "saveSegue"{
            print("Save Segue")
            
        }
        else if segue.identifier == "addReminderSegue"{
            print("Add Reminder Segue Taken")
            
            // Send time one
            if let time1 = Globals.timesDictionary[Globals.timeOneKey]{
                let timeOneStr = dateFormat.string(from: time1)
                print("Time 1 Str: \(timeOneStr)")
            }
            // Send time two
            if let time2 = Globals.timesDictionary[Globals.timeTwoKey]{
                let timeTwoStr = dateFormat.string(from: time2)
                print("Time 2 Str: \(timeTwoStr)")
            }
            // Send time three
            if let time3 = Globals.timesDictionary[Globals.timeThreeKey]{
                let timeThreeStr = dateFormat.string(from: time3)
                print("Time 3 Str: \(timeThreeStr)")
            }
            
        }
    }
}
