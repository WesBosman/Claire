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
    var reminderString: String = ""
    var editName: String = ""
    var editTime: String = ""
    var editReminder: String = ""
    var editDay: String = ""
    var editDiet:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: #selector(MedicationTableViewController.refreshList), name: "medicationList", object: nil)
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        self.tableView.allowsSelection = false
        self.tableView.allowsSelectionDuringEditing = true
        tableView.delegate = self
    }
    
    func refreshList(){
        medItemList = MedicationItemList.sharedInstance.allMeds()
        tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
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
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medItemList.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }

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
        
        // If medication time and diet are not empty print that they are on
        if !(medicationItem.reminderOne.isEmpty){
            cell.medicationReminder.text = "reminder: on"
            reminderString = String(medicationItem.reminderOne[0]) + ":" + String(medicationItem.reminderOne[1])
        }
        if !(medicationItem.reminderTwo.isEmpty){
            cell.medicationReminder.text = "reminder: on"
            reminderString = String(medicationItem.reminderTwo[0]) + ":" + String(medicationItem.reminderTwo[1])
        }
        if !(medicationItem.reminderThree.isEmpty){
            cell.medicationReminder.text = "reminder: on"
            reminderString = String(medicationItem.reminderThree[0]) + ":" + String(medicationItem.reminderThree[1])
        }
        else{
            cell.medicationReminder.text = "reminder: off"
        }

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
            // Delete the row from the data source
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
            let destination = segue.destinationViewController as! TableViewController
            if let selectedCell = sender as? MedicationCell{
                let indexPath = tableView.indexPathForCell(selectedCell)!
                let selectedMedication = medItemList[indexPath.row]
                
                destination.editingMedication = selectedMedication
                destination.editName = selectedCell.medicationName.text!
                destination.editingDays = selectedCell.medicationDays.text!

                destination.editTimes = selectedCell.medicationTimes.text!
                if selectedCell.medicationReminder.text == "reminder: on"{
                    //reminder one
                    if !(selectedMedication.reminderOne.isEmpty){
                        destination.editRemember = String(selectedMedication.reminderOne[0]) + ":" + String(selectedMedication.reminderOne[1])
                    }
                    // reminder two
                    if !(selectedMedication.reminderTwo.isEmpty){
                        destination.editRemember += " " + String(selectedMedication.reminderTwo[0]) + ":" + String(selectedMedication.reminderTwo[1])
                    }
                    // reminder three
                    if !(selectedMedication.reminderThree.isEmpty){
                        destination.editRemember += " " + String(selectedMedication.reminderThree[0]) + ":" + String(selectedMedication.reminderThree[1])
                    }
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