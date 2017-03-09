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
import ChameleonFramework
import DZNEmptyDataSet
import FontAwesome_swift
import RealmSwift

class MedicationTableViewController:
    UITableViewController,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate {
    
    var meds: [Medication]      = []
    var notificationTimeSet     = Set<Date>()
    var tableIsBeingEdited:Bool = false
    var reminderString: String  = String()
    var editName: String        = String()
    var editTime: String        = String()
    var editReminder: String    = String()
    var editDay: String         = String()
    var editDiet:String         = String()
    var selectedIndexPath:IndexPath? = nil
    let dateformatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(MedicationTableViewController.refreshList),
                         name: NSNotification.Name(rawValue: "medicationList"),
                         object: nil)
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.tableView.allowsSelection = false
        self.tableView.allowsSelectionDuringEditing = true
        tableView.delegate = self
        
        // Set the nav bar colors
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = .black
        nav?.barTintColor = UIColor.purple
        nav?.tintColor = UIColor.white
        
        // Set the carrier contrast
        //self.setThemeUsingPrimaryColor(UIColor.purple, with: .contrast)
        
        // Set the empty table view delegate and datasource
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.tableFooterView = UIView()
        
        // Set the table view to automatic dimensioning
        self.tableView.estimatedRowHeight = 130
        self.tableView.rowHeight = UITableViewAutomaticDimension
        dateformatter.dateFormat = "h:mm a"
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Welcome"
        let attributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Create a new Medication reminder by clicking the add button"
        let attributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attributes)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let image = UIImage.fontAwesomeIcon(.medkit  , textColor: UIColor.purple, size: CGSize(width: 40, height: 40))
        return image
    }
    
    func refreshList(){
        print("Refresh medication items list.")
        do{
            let realm = try Realm()
            let realmMeds = realm.objects(Medication.self)
            meds = Array(realmMeds)
            print("Meds count \(meds.count)")
        }catch let err as NSError{
            print("Error: \(err.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshList()
    }
    
    @IBAction func unwindToHome(_ myUnwind: UIStoryboardSegue){
        refreshList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meds.count
    }

    // Need to edit this a bit more.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCells", for: indexPath) as! MedicationCell
        let med = meds[indexPath.row]
        var dateString = String()
        var reminderString = String()
        
        // Get all the medication and reminder times
        if let t1 = med.timeOne{
            dateString += "T1: \(dateformatter.string(from: t1))\n"
        }
        if let t2 = med.timeTwo{
            dateString += "T2: \(dateformatter.string(from: t2))\n"
        }
        if let t3 = med.timeThree{
            dateString += "T3: \(dateformatter.string(from: t3))"
        }
        if let r1 = med.reminderOne{
            reminderString += "R1: \(dateformatter.string(from:r1))\n"
        }
        if let r2 = med.reminderTwo{
            reminderString += "R2: \(dateformatter.string(from:r2))\n"
        }
        if let r3 = med.reminderThree{
            reminderString += "R3: \(dateformatter.string(from:r3))"
        }
        
        cell.medicationName.text     = med.name
        cell.dosesToTake.text        = "Doses per day \(med.dosesPerDay)"
        cell.medicationDays.text     = med.daysToTakeString
        cell.medicationTimes.text    = dateString
        cell.medicationReminder.text = reminderString
        cell.intervalLabel.text      = med.notificationRepeatString
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source.
            tableIsBeingEdited = true
            
            // Remove the medication item from the list and delete the row at the indexPath.
            let med = meds[indexPath.row]
            MedicationList().removeMedicationInDb(med: med)
            meds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "editMedication"{
            print("edit medication segue taken")
            // get the information from the cell that was selected. 
            
        }
        else if segue.identifier == "addMedication"{
            print("Add medication segue taken")
        }
    }
}
