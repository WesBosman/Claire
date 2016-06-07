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

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reminderSwitchPressed(sender: AnyObject) {
        togglePickerTitle()
    }
    
//    @IBAction func saveButtonPressed(sender: AnyObject) {
//        let timerString = setTimeDetailLabel.text
//        print("Timer String: \(timerString)")
//        //self.navigationController?.popViewControllerAnimated(true)
//    }
    
    func togglePickerTitle(){
        timePickerTitle = !timePickerTitle
        timePickerHidden = !timePickerHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
//    func togglePicker(){
//        timePickerHidden = !timePickerHidden
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
    
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("Segue Id: \(segue.identifier!)")
        if segue.identifier! == "UnwindAddReminder" {
            let destination = segue.destinationViewController as! TableViewController
            destination.reminderRightDetail.text = setTimeDetailLabel.text!
            destination.viewWillAppear(true)
            print("Set Time Label: \(setTimeDetailLabel.text!)")
        }
    }

}
