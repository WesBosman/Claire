//
//  RepeatDaysTableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/4/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class RepeatDaysTableViewController: UITableViewController {
    var listOfDays = Set<String>()
    var listOfDaysAsString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This turns the checkmarks on or off
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selection = tableView.cellForRowAtIndexPath(indexPath)
        let day = selection?.textLabel?.text
        // IF the accessory type is a checkmark turn it off and remove the day from the set
        if selection?.accessoryType == UITableViewCellAccessoryType.Checkmark{
            selection!.accessoryType = UITableViewCellAccessoryType.None
            if listOfDays.contains(day!){
                let index = listOfDays.indexOf(day!)
                listOfDays.removeAtIndex(index!)
                print("Remove \(day!) at index \(index!)")
            }
        }
        // Otherwise turn the checkmark on and add the day to the set
        else{
            selection!.accessoryType = UITableViewCellAccessoryType.Checkmark
            listOfDays.insert(day!)
            listOfDaysAsString += day! + ", "
            print("Add \(day!)")
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    // MARK: - Table view data source
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return daysOfTheWeek.count
    }
     */
    /**
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
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
        if segue.identifier! == "UnwindAddDays"{
            let destination = segue.destinationViewController as! TableViewController
            destination.repeatRightDetail.text = listOfDaysAsString
            destination.medicationDaysSet = listOfDays
            print("List of Days as String: \(listOfDaysAsString)")
            print("List of days: \(listOfDays)")
            
        }
    }
    
    
}
