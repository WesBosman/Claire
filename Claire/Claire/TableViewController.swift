//
//  TableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/2/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var dayAndNightSwitch: UISwitch!
    @IBOutlet weak var dietSwitch: UISwitch!
    @IBOutlet weak var timeToTakeMedicineDatePicker: UIDatePicker!
    private var timeToTakeMedicationHidden = false
    private var medicationNameHidden = false
    private var repeatingPickerHidden = false
    @IBOutlet weak var timeToTakeMedsRightDetail: UILabel!
    @IBOutlet weak var medicationNameRightDetail: UILabel!
    var daysOfTheWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Everyday"]
    @IBOutlet weak var repeatingPickerView: UIPickerView!
    @IBOutlet weak var repeatRightDetail: UILabel!
    @IBOutlet weak var medicationNameTextBox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Toggle and Hide cells
        toggleTakeMedicationPicker()
        toggleMedicationName()
        toggleRepeatingPicker()
        // We only want time for our date picker
        timeToTakeMedicineDatePicker.datePickerMode = UIDatePickerMode.Time
        timeToTakeMedsRightDetail.text = ""
        medicationNameRightDetail.text = ""
        repeatRightDetail.text = daysOfTheWeek[0]
        repeatingPickerView.dataSource = self
        repeatingPickerView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func medicationNameEnterPressed(sender: AnyObject) {
        medicationNameRightDetail.text = medicationNameTextBox.text
        toggleMedicationName()
        
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
        medicationTimeDidChange()
    }
    
    func medicationTimeDidChange(){
        timeToTakeMedsRightDetail.text = NSDateFormatter.localizedStringFromDate(timeToTakeMedicineDatePicker.date, dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    func toggleMedicationName(){
        medicationNameHidden = !medicationNameHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTakeMedicationPicker(){
        timeToTakeMedicationHidden = !timeToTakeMedicationHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleRepeatingPicker(){
        repeatingPickerHidden = !repeatingPickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Toggle the drop down medication name.
        if indexPath.section == 0 && indexPath.row == 0{
            toggleMedicationName()
        }
        // Toggle the date picker to select a time to take the medication.
        else if indexPath.section == 1 && indexPath.row == 0{
            toggleTakeMedicationPicker()
        }
        // Toggle the repeat picker
        else if indexPath.section == 3 && indexPath.row == 0{
            toggleRepeatingPicker()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // Hide the medication name cell
        if medicationNameHidden && indexPath.section == 0 && indexPath.row == 1 {
            return 0
        }
        // Hide the time picker for the medication
        else if timeToTakeMedicationHidden && indexPath.section == 1 && indexPath.row == 1{
            return 0
        }
        // Hide the repeating picker
        else if repeatingPickerHidden && indexPath.section == 3 && indexPath.row == 1{
            return 0
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return daysOfTheWeek[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysOfTheWeek.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        repeatRightDetail.text = daysOfTheWeek[row]
    }

    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
