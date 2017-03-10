//
//  ChartViewController.swift
//  Claire
//
//  Created by Wes Bosman on 3/9/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class ChartViewController:
    UIViewController,
    ChartViewDelegate{
    
    @IBOutlet weak var lineChart: LineChartView!
    let dateformatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = .black
        nav?.barTintColor = UIColor.purple
        nav?.tintColor = UIColor.white

        // Do any additional setup after loading the view.
        self.lineChart.delegate = self
        dateformatter.dateFormat = "M/d/yyyy"
        setUpLineChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dateformatter.dateFormat = "M/d/yyyy"
        setUpLineChart()
    }
    
    func setUpLineChart(){
        lineChart.borderColor = UIColor.purple
        lineChart.noDataText  = "No Data to Display"
        lineChart.noDataTextColor = UIColor.orange
        lineChart.borderLineWidth = 2
        lineChart.gridBackgroundColor = UIColor.orange
        
        // Set up arrays to get the skipped and taken values
//        var days: [String]= []
        var skippedData: [ChartDataEntry] = []
        var takenData:   [ChartDataEntry] = []
        
        
        
        if let medItems = getMedItemsFromDatabase(){
            
            for i in 0..<Array(medItems).count{
                let medItem   = medItems[i]
                let taken = ChartDataEntry(x: Double(i), y: Double(medItem.timesTaken))
                let skipped = ChartDataEntry(x: Double(i), y: Double(medItem.timesSkipped))
                
                // Append the data to the chart
                takenData.append(taken)
                skippedData.append(skipped)
//                days.append(dateformatter.string(from: medItem.date!))
                
            }
            
            let skippedSet: LineChartDataSet = LineChartDataSet(values: skippedData, label: "Skipped Medications")
            let takenSet: LineChartDataSet = LineChartDataSet(values: takenData, label: "Taken Medications")
            
            // Skipped Set
            skippedSet.axisDependency = .left
            skippedSet.setCircleColor(UIColor.red)
            skippedSet.lineWidth = 2.0
            skippedSet.fillColor = UIColor.red
            skippedSet.circleHoleRadius = 4.0
            skippedSet.drawCirclesEnabled = true
            skippedSet.drawCircleHoleEnabled = true
            
            // Taken Set
            takenSet.axisDependency = .left
            takenSet.setCircleColor(UIColor.blue)
            takenSet.lineWidth = 2.0
            takenSet.fillColor = UIColor.blue
            takenSet.circleHoleRadius = 4.0
            takenSet.drawCirclesEnabled = true
            takenSet.drawCircleHoleEnabled = true
            
            // Append data sets
            var dataSets: [LineChartDataSet] = []
            dataSets.append(skippedSet)
            dataSets.append(takenSet)
            
            // Set up data for chart
            let data:LineChartData = LineChartData(dataSets: dataSets)
            data.setValueTextColor(UIColor.flatNavyBlue)
            
            // Send data to chart
            self.lineChart.data = data
        }
    }
    
    func getMedItemsFromDatabase() -> Results<Medication>?{
        do{
            let realm = try Realm()
            return realm.objects(Medication.self)
        }
        catch let err as NSError{
            print("Error getting chart items from database \(err.localizedDescription)")
        }
        return nil
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
