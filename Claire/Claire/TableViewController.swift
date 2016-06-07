//
//  TableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/2/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{

    @IBOutlet weak var dayAndNightSwitch: UISwitch!
    @IBOutlet weak var dietSwitch: UISwitch!
    @IBOutlet weak var timeToTakeMedicineDatePicker: UIDatePicker!
    private var timeToTakeMedicationHidden = false
    private var medicationNameHidden = false
    private var repeatingPickerHidden = false
    @IBOutlet weak var timeToTakeMedsRightDetail: UILabel!
    @IBOutlet weak var repeatRightDetail: UILabel!
    @IBOutlet weak var medicationNameTextBox: UITextField!
    @IBOutlet weak var numberOfTimesRightDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // We only want time for our date picker
        //timeToTakeMedsRightDetail.text = ""
        medicationNameTextBox.placeholder = "Name of Medication"
        numberOfTimesRightDetail.text = nil

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        repeatRightDetail.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Toggle the date picker to select a time to take the medication.
        if indexPath.section == 1 && indexPath.row == 0{
            toggleTakeMedicationPicker()
        }
        // Toggle the repeat picker
        else if indexPath.section == 3 && indexPath.row == 0{
            toggleRepeatingPicker()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // Hide the time picker for the medication
        if timeToTakeMedicationHidden && indexPath.section == 1 && indexPath.row == 1{
            return 0
        }
        // Hide the repeating picker
        else if repeatingPickerHidden && indexPath.section == 3 && indexPath.row == 1{
            return 0
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        
    }
    */

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
