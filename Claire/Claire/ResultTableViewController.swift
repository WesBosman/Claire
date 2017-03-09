//
//  ResultTableViewController.swift
//  Claire
//
//  Created by Wes Bosman on 6/8/16.
//  Copyright © 2016 Wes Bosman. All rights reserved.
//

import UIKit
import Charts
import DZNEmptyDataSet

class ResultTableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the nav bar colors
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = .black
        nav?.barTintColor = UIColor.purple
        nav?.tintColor = UIColor.white
        
        // Set empty data source table view
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Welcome"
        let attributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Currently there are no results to display"
        let attributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attributes)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let image = UIImage.fontAwesomeIcon(.barChart  , textColor: UIColor.purple, size: CGSize(width: 40, height: 40))
        return image
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}
