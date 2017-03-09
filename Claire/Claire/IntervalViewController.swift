//
//  IntervalViewController.swift
//  Claire
//
//  Created by Wes Bosman on 3/9/17.
//  Copyright © 2017 Wes Bosman. All rights reserved.
//

import UIKit

class IntervalViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource{
    
    @IBOutlet weak var intervalTableView: UITableView!
    let cellID = "IntervalCellIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        intervalTableView.dataSource = self
        intervalTableView.delegate = self
        intervalTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Globals.notificationRepeatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        let title = Globals.notificationRepeatArray[indexPath.row]
        cell.textLabel?.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            Globals.selectedInterval   = (cell.textLabel?.text!)!
            print("Did select Interval -> \(Globals.selectedInterval)")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = UITableViewCellAccessoryType.none
            Globals.selectedInterval = String()
            print("Did deselect Interval")
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
