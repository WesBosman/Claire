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
            print("Add \(day!)")
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    // Got these next two methods from Sandeep on stackoverflow
    func formattedDaysInThisWeek() -> [String] {
        // create calendar
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        
        // today's date
        let today = NSDate()
        let todayComponent = calendar.components([.Day, .Month, .Year], fromDate: today)
        
        // range of dates in this week
        let thisWeekDateRange = calendar.rangeOfUnit(.Day, inUnit:.WeekOfMonth, forDate:today)
        
        // date interval from today to beginning of week
        let dayInterval = thisWeekDateRange.location - todayComponent.day
        
        // date for beginning day of this week, ie. this week's Sunday's date
        let beginningOfWeek = calendar.dateByAddingUnit(.Day, value: dayInterval, toDate: today, options: .MatchNextTime)
        
        var formattedDays: [String] = []
        
        for i in 0 ..< thisWeekDateRange.length {
            let date = calendar.dateByAddingUnit(.Day, value: i, toDate: beginningOfWeek!, options: .MatchNextTime)!
            formattedDays.append(formatDate(date))
        }
        
        return formattedDays
    }
    
    func formatDate(date: NSDate) -> String {
        let format = "EEEE MMMM dd yyyy"
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier! == "UnwindAddDays"{
            let destination = segue.destinationViewController as! TableViewController
            let daysOfWeek = formattedDaysInThisWeek()
            for day in daysOfWeek{
                for newDay in listOfDays.reverse(){
                    if day.hasPrefix(newDay){
                        listOfDaysAsString += newDay + " "
                        listOfDays.remove(newDay)
                        listOfDays.insert(day)
                    }
                }
            }
            
            destination.repeatRightDetail.text = listOfDaysAsString
            destination.medicationDaysSet = listOfDays
            
        }
    }
    
    
}
