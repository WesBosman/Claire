//
//  EditMedicationNavigationController.swift
//  Claire
//
//  Created by Wes Bosman on 6/9/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class EditMedicationNavigationController: UINavigationController {
    var editingName:String = ""
    var editingTime:String = ""
    var editingDays:String = ""
    var editingReminder:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editingMedicationSegue"{
            let destination = segue.destinationViewController as! MedicationStaticTableViewController
            destination.medicationNameTextBox.text = editingName
            destination.numberOfTimesRightDetail.text = editingTime
            destination.reminderRightDetail.text = editingReminder
            destination.repeatRightDetail.text = editingDays
            print("Editing medication segue from navigation controller")
//            print("editing name: \(editingName)")
//            print("Editing Time: \(editingTime)")
//            print("Editing Reminder: \(editingReminder)")
//            print("Repeat Right Detail: \(editingDays)")
        }
    }

}
