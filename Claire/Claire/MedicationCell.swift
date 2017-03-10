//
//  MedicationCell.swift
//  Claire
//
//  Created by Wes Bosman on 6/7/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit
import RealmSwift

class MedicationCell: UITableViewCell {

    @IBOutlet weak var medicationName:     UILabel!
    @IBOutlet weak var medicationTimes:    UILabel!
    @IBOutlet weak var medicationReminder: UILabel!
    @IBOutlet weak var medicationDays:     UILabel!
    @IBOutlet weak var skippedButton:      UIButton!
    @IBOutlet weak var takenButton:        UIButton!
    @IBOutlet weak var dosesToTake: UILabel!
    @IBOutlet weak var intervalLabel: UILabel!
    
    
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
    
}
