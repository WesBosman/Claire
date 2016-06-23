//
//  MedicationTableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/7/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//
//  Using Icon Beast Lite for images for this application
//  Link to their information
//  Author: Charlene
//  Website: http://www.iconbeast.com
//  Email: thebeast@iconbeast.com

import UIKit

class MedicationTableViewController: UITableViewController {
    var medItemList: [MedicationItem] = []
    var notificationTimeSet = Set<NSDate>()
    var isExpanded:Bool = false
    var tableIsBeingEdited:Bool = false
    var reminderString: String = ""
    var editName: String = ""
    var editTime: String = ""
    var editReminder: String = ""
    var editDay: String = ""
    var editDiet:String = ""
    var selectedIndexPath:NSIndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter()
            .addObserver(self,
                         selector: #selector(MedicationTableViewController.refreshList),
                         name: "medicationList",
                         object: nil)
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.tableView.allowsSelection = false
        self.tableView.allowsSelectionDuringEditing = true
        tableView.delegate = self
    }
    
    func refreshList(){
        print("Refresh medication items list.")
        medItemList = MedicationItemList.sharedInstance.allMeds()
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.barTintColor = UIColor.purpleColor()
        nav?.tintColor = UIColor.whiteColor()
        refreshList()
    }
    
    @IBAction func unwindToHome(myUnwind: UIStoryboardSegue){
        refreshList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source  
    func toggleExpanded(cell: MedicationCell){
        isExpanded = !isExpanded
        
        // If the cell is not expanded then hide the buttons and the days
        if isExpanded == false{
            cell.skippedButton.hidden = true
            cell.takenButton.hidden = true
            cell.medicationDays.hidden = true
        }
        // If the cell is expanded then show the buttons and days.
        else if isExpanded == true{
            cell.skippedButton.hidden = false
            cell.takenButton.hidden = false
            cell.medicationDays.hidden = false
        }
        // Update the table
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medItemList.count
    }
    
    // If the user taps an accessory button expand that row.
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {

        // Get the cell based on the IndexPath
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath) as! MedicationCell
        
        // Set the selected IndexPath to the indexPath for the selected cell
        selectedIndexPath = tableView.indexPathForCell(selectedCell)
        
        if selectedIndexPath!.row == indexPath.row && selectedIndexPath?.section == indexPath.section{
            toggleExpanded(selectedCell)
        }
    }
    
    // Expand the tableView Cell is isExpanded is equal to true
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isExpanded && selectedIndexPath!.row == indexPath.row && selectedIndexPath?.section == indexPath.section{
            return 120
        }
        else{
            return 60
        }
    }

    // Need to edit this a bit more.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MedicationCells", forIndexPath: indexPath) as! MedicationCell
        let medicationItem = medItemList[indexPath.row]
        
        // Configure the cell...
        cell.medicationName.text = medicationItem.medicationName
        editName = medicationItem.medicationName
        cell.medicationDays.text = medicationItem.medicationDays
        editDay = medicationItem.medicationDays
        cell.medicationTimes.text = medicationItem.medicationTimes
        editTime = medicationItem.medicationTimes
        
        
        if !(medicationItem.reminderOne.isEmpty){
            cell.medicationReminder.text = "reminder: on"
            reminderString = String(medicationItem.reminderOne[0]) + ":" + String(medicationItem.reminderOne[1])
        }
        else if !(medicationItem.reminderTwo.isEmpty){
            cell.medicationReminder.text = "reminder: on"
            reminderString = String(medicationItem.reminderTwo[0]) + ":" + String(medicationItem.reminderTwo[1])
        }
        else if !(medicationItem.reminderThree.isEmpty){
            cell.medicationReminder.text = "reminder: on"
            reminderString = String(medicationItem.reminderThree[0]) + ":" + String(medicationItem.reminderThree[1])
        }
        else{ cell.medicationReminder.text = "reminder: off" }

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source.
            tableIsBeingEdited = true
            
            // Remove the medication item from the list and delete the row at the indexPath.
            let itemToDelete = medItemList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            MedicationItemList.sharedInstance.removeItem(itemToDelete)
        }
    }
    

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "editMedicationSegue"{
            print("edit medication segue taken")
            // get the information from the cell that was selected. 
            let destination = segue.destinationViewController as! MedicationStaticTableViewController
            if let selectedCell = sender as? MedicationCell{
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedMedication = medItemList[indexPath.row]
                
                destination.editingMedication = selectedMedication
                destination.editName = selectedCell.medicationName.text!
                destination.editingDays = selectedCell.medicationDays.text!
                destination.editTimes = selectedCell.medicationTimes.text!
                
                print("Edit medication segue")
                print("Selected Medication: \(selectedMedication)")
                print("Medication name: \(selectedCell.medicationName.text!)")
                print("Medication days: \(selectedCell.medicationDays.text!)")
                print("Medication times: \(selectedCell.medicationTimes.text!)")
                print("Medication reminder: \(reminderString)")

                
                if selectedCell.medicationReminder.text == "reminder: on"{
                    destination.editRemember = reminderString
                }
                else{
                    destination.editRemember = ""
                }

                destination.editingPreviousEntry = true
            }

            
        }
        else if segue.identifier == "addMedicationSegue"{
            print("Add medication segue taken")
        }
    }
}