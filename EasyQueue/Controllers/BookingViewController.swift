//
//  BookingViewController.swift
//  EasyQueue
//
//  Created by Ling Chen on 27/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //var menuName = ""
    var selectedSegment = 1
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedSegment = 1
        } else {
            selectedSegment = 2
        }
        self.tableView.reloadData()// everytime user change segment, tableview need to reload data
    }

    let DB = EasyQueueDB()
    var currentBookings: [[String:Any]] = [[:]]
    var historyBookings: [[String:Any]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        currentBookings = DB.getBookings(status: 0) // get current (alive) bookings
        historyBookings = DB.getBookings(status: 2) // get history (finished) bookings        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 1 {
            return currentBookings.count
        } else {
            return historyBookings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedSegment == 1{
            let currentBookingCell = UITableViewCell(style: .subtitle, reuseIdentifier: "currentCell")
            currentBookingCell.imageView?.image = UIImage(named: currentBookings[indexPath.row]["image"] as! String)
            currentBookingCell.textLabel?.text = "# \(currentBookings[indexPath.row]["number"]!)"
            currentBookingCell.detailTextLabel?.text = (currentBookings[indexPath.row]["resName"] as! String)
            return currentBookingCell
        } else {
            let historyBookingCell = UITableViewCell(style: .subtitle, reuseIdentifier: "historyCell")
            historyBookingCell.imageView?.image = UIImage (named: currentBookings[indexPath.row]["image"] as! String)
            historyBookingCell.textLabel?.text = "# \(historyBookings[indexPath.row]["number"]!)"
            historyBookingCell.detailTextLabel?.text = (historyBookings[indexPath.row]["resName"] as! String)
            return historyBookingCell
        }
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let myIndex = indexPath.row
//        menuName = currentBookings[myIndex]["menuName"] as! String
//        performSegue(withIdentifier: "BookingToMenu", sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller : ViewController = segue.destination as! ViewController
//        controller.menuString = menuName
//    }
    
    
    
}
