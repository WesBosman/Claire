//
//  MedicationCell.swift
//  Claire
//
//  Created by Wes Bosman on 6/7/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class MedicationCell: UITableViewCell {

    @IBOutlet weak var medicationName:     UILabel!
    @IBOutlet weak var medicationTimes:    UILabel!
    @IBOutlet weak var medicationReminder: UILabel!
    @IBOutlet weak var medicationDays:     UILabel!
    @IBOutlet weak var skippedButton:      UIButton!
    @IBOutlet weak var takenButton:        UIButton!
    @IBOutlet weak var dosesToTake: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    var timesTaken   = 0
    var timesSkipped = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        medicationDays.lineBreakMode = NSLineBreakMode.byWordWrapping
        medicationDays.numberOfLines = 0
        medicationReminder.lineBreakMode = NSLineBreakMode.byWordWrapping
        medicationDays.numberOfLines = 0
        skippedButton.layer.backgroundColor = UIColor.purple.cgColor
        skippedButton.layer.cornerRadius = 10
        skippedButton.setTitleColor(UIColor.white, for: .normal)
        skippedButton.setTitleColor(UIColor.flatGray, for: .selected)
        takenButton.layer.backgroundColor = UIColor.purple.cgColor
        takenButton.layer.cornerRadius = 10
        takenButton.setTitleColor(UIColor.white, for: .normal)
        takenButton.setTitleColor(UIColor.flatGray, for: .selected)
    }
    
    // Do something when the user skipped their medication
    @IBAction func skippedButtonPressed(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you want to skip taking this medication? \nMedication Name: \(medicationName.text!)", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: {(action: UIAlertAction) in
            // Add one to the number of times skipped
            self.timesSkipped += 1
            print("Skipped Button is enabled -> \(self.timesSkipped)")
            self.skippedButton.layer.backgroundColor = UIColor.flatPlumDark.cgColor
        })
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        

    }
    
    // Do something when the user took their medication
    @IBAction func takenButtonPressed(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Alert", message: "Are you sure you have taken this medication today? \nMedication Name: \(medicationName.text!)", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .default, handler: {(action) in
            self.timesTaken += 1
            print("Taken Button is enabled -> \(self.timesTaken)")
            self.takenButton.layer.backgroundColor = UIColor.flatPlumDark.cgColor
        })
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(no)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
