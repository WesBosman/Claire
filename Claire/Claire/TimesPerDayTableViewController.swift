//
//  TimesPerDayTableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/4/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class TimesPerDayTableViewController: UITableViewController {
    @IBOutlet weak var timeOneSubtitle: UILabel!
    @IBOutlet weak var timeOneDatePicker: UIDatePicker!
    @IBOutlet weak var timeTwoSubtitle: UILabel!
    @IBOutlet weak var timeTwoDatePicker: UIDatePicker!
    private var timeOneTitleIsHidden = false
    private var timeTwoTitleIsHidden = false
    private var timeThreeTitleIsHidden = false
    private var timePickerOneIsHidden = false
    private var timePickerTwoIsHidden = false
    private var timePickerThreeIsHidden = false
    private var daysSelected = []
    @IBOutlet weak var timeThreeDatePicker: UIDatePicker!
    @IBOutlet weak var timeThreeSubtitle: UILabel!
    let timeFormat: NSDateFormatter = NSDateFormatter()
    private let date = NSDate()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Toggle time pickers
        toggleTimeOneTitle()
        toggleTimeTwoTitle()
        toggleTimeThreeTitle()
        toggleTimeOnePicker()
        toggleTimeTwoPicker()
        toggleTimeThreePicker()
        
        // Set the datepicker modes to time
        timeOneDatePicker.datePickerMode = UIDatePickerMode.Time
        timeTwoDatePicker.datePickerMode = UIDatePickerMode.Time
        timeThreeDatePicker.datePickerMode = UIDatePickerMode.Time
        
        timeFormat.dateStyle = NSDateFormatterStyle.ShortStyle        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func toggleTimeOneTitle(){
        timeOneTitleIsHidden = !timeOneTitleIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeTwoTitle(){
        timeTwoTitleIsHidden = !timeTwoTitleIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeThreeTitle(){
        timeThreeTitleIsHidden = !timeThreeTitleIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeOnePicker(){
        timePickerOneIsHidden = !timePickerOneIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeTwoPicker(){
        timePickerTwoIsHidden = !timePickerTwoIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func toggleTimeThreePicker(){
        timePickerThreeIsHidden = !timePickerThreeIsHidden
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func timeOneDatePickerAction(sender: AnyObject) {
        //timeOneDatePickerChanged()
    }

    @IBAction func timeTwoDatePickerAction(sender: AnyObject) {
        timeTwoDatePickerChanged()
    }

    @IBAction func timeThreeDatePickerAction(sender: AnyObject) {
        timeThreeDatePickerChanged()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if timePickerOneIsHidden && indexPath.section == 1 && indexPath.row == 1{
            return 0
        }
        else if timeOneTitleIsHidden && indexPath.section == 1 && indexPath.row == 0{
            return 0
        }
        else if timePickerTwoIsHidden && indexPath.section == 1 && indexPath.row == 3{
            return 0
        }
        else if timeTwoTitleIsHidden && indexPath.section == 1 && indexPath.row == 2{
            return 0
        }
        else if timePickerThreeIsHidden && indexPath.section == 1 && indexPath.row == 5{
            return 0
        }
        else if timeThreeTitleIsHidden && indexPath.section == 1 && indexPath.row == 4{
            return 0
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2){
            toggleCheckmark(tableView, indexPath: indexPath)
            if indexPath.row == 0{
                toggleTimeOneTitle()
            }
            else if indexPath.row == 1{
                toggleTimeTwoTitle()
            }
            else if indexPath.row == 2{
                toggleTimeThreeTitle()
            }
        }
        else if indexPath.section == 1 && indexPath.row == 0{
            toggleTimeOnePicker()
        }
        else if indexPath.section == 1 && indexPath.row == 2{
            toggleTimeTwoPicker()
        }
        else if indexPath.section == 1 && indexPath.row == 4{
            toggleTimeThreePicker()
        }
        else{
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func toggleCheckmark(tableView: UITableView, indexPath: NSIndexPath){
        // Get a cell and change the accessory type
        let selection = tableView.cellForRowAtIndexPath(indexPath)
        
        if selection?.accessoryType == UITableViewCellAccessoryType.None{
            selection?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else{
            selection?.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    func timeOneDatePickerChanged(){
        //timeOneSubtitle.text = ""
    }
    
    func timeTwoDatePickerChanged(){
        //timeTwoSubtitle.text = ""
    }
    
    func timeThreeDatePickerChanged(){
        //timeThreeSubtitle.text = ""
    }
    
    // MARK: - Table view data source
    /**
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    **/
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
