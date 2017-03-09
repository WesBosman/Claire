//
//  CalendarPickerViewController.swift
//  Claire
//
//  Created by Wes Bosman on 3/9/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarPickerViewController:
    UIViewController,
    FSCalendarDelegate,
    FSCalendarDataSource{
    
    @IBOutlet weak var fsCalendar: FSCalendar!
    let userCalendar  = Calendar.current
    let today = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fsCalendar.delegate = self
        fsCalendar.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Return the calendar's minimum date
    func minimumDate(for calendar: FSCalendar) -> Date {
        var dateComp = userCalendar.dateComponents([.month, .year], from: today)
        dateComp.day = 1
        let minDate = userCalendar.date(from: dateComp)!
        print("Min Date For Calendar \(minDate)")
        return minDate
    }
    
    // Return the calendar's max date
    func maximumDate(for calendar: FSCalendar) -> Date {
        var dateComp = userCalendar.dateComponents([.year], from: today)
        dateComp.month = 12
        dateComp.day   = 31
        let maxDate = userCalendar.date(from: dateComp)
        print("Max Date For Calendar \(maxDate)")
        return maxDate!
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected Date -> \(date)")
        Globals.selectedDates.append(date)
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if let index = Globals.selectedDates.index(of: date){
            print("Deselected Date -> \(date)")
            print("Found the date in the array removing it")
            Globals.selectedDates.remove(at: index)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
