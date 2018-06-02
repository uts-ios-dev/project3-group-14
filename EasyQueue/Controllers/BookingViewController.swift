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
        
        //keys: id,resName,que.number,que.status,menuName,res.image
        currentBookings = DB.getBookings(status: 0) // get current (alive) bookings
        historyBookings = DB.getBookings(status: 2) // get history (finished) bookings
    }
    
    // set costum cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    // set number of rows based on selected segment control
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSegment == 1 {
            return currentBookings.count
        } else {
            return historyBookings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // configure cells for current Bookings
        if selectedSegment == 1{
            let currentBookingCell = tableView.dequeueReusableCell(withIdentifier: "currentCell", for: indexPath) as! CurrentBookingTableViewCell
            currentBookingCell.restaurantImage.image = UIImage(named: currentBookings[indexPath.row]["image"] as! String)
            currentBookingCell.bookingNumberLabel.text = "# \(currentBookings[indexPath.row]["number"]!)"
            currentBookingCell.restaurantNameLabel.text = (currentBookings[indexPath.row]["resName"] as! String)
            // calculate number of people waiting
            let rid = currentBookings[indexPath.row]["id"] as! Int
            var queue = DB.getQueueSystem(rid:rid)
            let currentQueueNumInRestaurant = queue["current"] as! Int
            let currentQueueNumber = currentBookings[indexPath.row]["number"] as! Int
            let numOfPeopleWaiting = currentQueueNumber - currentQueueNumInRestaurant
            currentBookingCell.numberOfPeopleWaitingLabel.text = "\(numOfPeopleWaiting) people waiting"
            currentBookingCell.timeLeftLabel.text = "\(numOfPeopleWaiting * 5) mins "
            return currentBookingCell
        // configure cells for history bookings
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
