//
//  MedicationCell.swift
//  Claire
//
//  Created by Wes Bosman on 6/7/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit

class MedicationCell: UITableViewCell {

    @IBOutlet weak var medicationName: UILabel!
    @IBOutlet weak var medicationTimes: UILabel!
    @IBOutlet weak var medicationReminder: UILabel!
    @IBOutlet weak var medicationDays: UILabel!
    @IBOutlet weak var medicationDiet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
