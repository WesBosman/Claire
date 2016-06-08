//
//  TableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/2/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // We only want time for our date picker
        medicationNameTextBox.placeholder = "Name of Medication"
        numberOfTimesRightDetail.text = nil
        reminderRightDetail.text = nil
        repeatRightDetail.text = nil
        timeAfterEatingDetail.text = nil
        dietSwitch.tintColor = UIColor.purpleColor()
        dietSwitch.onTintColor = UIColor.purpleColor()
        dietSwitch.setOn(false, animated: true)
        timeAfterEatingFormat.dateFormat = "HH:mm"
        timeAfterEatingPicker.datePickerMode = UIDatePickerMode.CountDownTimer
        toggleTimeAfterEating()
        toggleTimeAfterEatingPicker()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        // If the name and the times and repeat are not null then continue.
        if (!medicationNameTextBox.text!.isEmpty && !numberOfTimesRightDetail.text!.isEmpty
            //&& !timeAfterEatingDetail.text!.isEmpty 
            && !repeatRightDetail.text!.isEmpty
            //&& !reminderRightDetail.text!.isEmpty
            ){
            let medication = MedicationItem(name: medicationNameTextBox.text!,
                                            time: numberOfTimesRightDetail.text!,
                                            diet: timeAfterEatingDetail.text ?? " ",
                                            days: repeatRightDetail.text!,
                                            reminder: reminderRightDetail.text ?? " ",
                                            UUID: NSUUID().UUIDString)
            print("Medication \(medication)")
            MedicationItemList.sharedInstance.addItem(medication)
            
        }
        else{
            let alert:UIAlertController = UIAlertController(title: "Missing A Field", message: "One or more of the reqired fields marked with an asterisk has not been filled in", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) in
                // Essentially do nothing. Unless we want to print some sort of log message.
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("TableView Did Appear Animated")
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
        print("Unwind action was called")
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

    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier! == "UnwindMedicationSegue"{
            

        }
    }
    */
}
