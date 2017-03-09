//
//  RepeatDaysTableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/4/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class RepeatDaysTableViewController: UITableViewController {
    var listOfDays:NSMutableOrderedSet =  NSMutableOrderedSet()
    var listOfDaysAsString: String     =  String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This turns the checkmarks on or off
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = tableView.cellForRow(at: indexPath)
        let day = selection?.textLabel?.text
        
        // Unwrap the Selected Cell
        if let selectedCell = selection{
            // If the accessory type is a checkmark then remove it
            if selectedCell.accessoryType == .checkmark{
                // Turn off the checkmark 
                selectedCell.accessoryType = .none
                // Remove the day from the set
                if let selectedDay = day{
                    let index = listOfDays.index(of: selectedDay)
                        listOfDays.removeObject(at: index)
                        print("Remove Selected Day: \(selectedDay)")
                }
            }
            // Otherwise turn the checkmark on and add
            else{
                // Add a checkmark and add a day to the set
                if let selectedCell = selection{
                    selectedCell.accessoryType = .checkmark
                    if let selectedDay = day{
                        // Insert a day into the set
                        listOfDays.add(selectedDay)
//                        addDayToList(day: selectedDay)
                        print("Add Selected Day: \(selectedDay)")
                    }
                }
            }
        }
        // Deselect the cell
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func addDayToList(day:String){
        switch(day){
        case "Sunday":
            listOfDays.insert(day, at: 0)
        case "Monday":
            listOfDays.insert(day, at: 1)
        case "Tuesday":
            listOfDays.insert(day, at: 2)
        case "Wednesday":
            listOfDays.insert(day, at: 3)
        case "Thursday":
            listOfDays.insert(day, at: 4)
        case "Friday":
            listOfDays.insert(day, at: 5)
        case "Saturday":
            listOfDays.insert(day, at: 6)
        default:
            return
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("Segue Identifier : \(segue.identifier!)")
        if segue.identifier! == "UnwindAddDays"{
            let destination = segue.destination as! MedicationStaticTableViewController
            
            for newDay in listOfDays{
                // Create a medication day to store in database
//                let medDay = MedicationDay()
//                medDay.day = newDay as! String
//                destination.medDays.append(medDay)
                
                // Update the right detail
                listOfDaysAsString += "\(newDay) "
                print("List of Days as String: \(listOfDaysAsString)")
            }
            
            destination.repeatRightDetail.text = listOfDaysAsString
        }
    }
}
