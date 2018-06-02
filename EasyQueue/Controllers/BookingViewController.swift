//
//  BookingViewController.swift
//  EasyQueue
//
//  Created by Ling Chen on 27/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedSegment = 1
    
    @IBOutlet weak var tableView: UITableView!
    //get selected segement index, 1 is for currentCells, 2 is for historyCell
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
    var restId = 0
    var queueId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //keys: id,resName,que.bookingNumber,que.status,menuName,res.image
        currentBookings = DB.getBookings(status: 1) // get current (alive) bookings
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
            let currentBookingCell = tableView.dequeueReusableCell(withIdentifier: "currentCell", for: indexPath) as! BookingTableViewCell
            currentBookingCell.restaurantImage.image = UIImage(named: currentBookings[indexPath.row]["image"] as! String)
            currentBookingCell.bookingNumberLabel.text = "# \(currentBookings[indexPath.row]["bookingNumber"]!)"
            currentBookingCell.restaurantNameLabel.text = (currentBookings[indexPath.row]["resName"] as! String)
            // calculate number of people waiting
            let currentQueueNumInRestaurant = currentBookings[indexPath.row]["current"] as! Int
            let currentQueueNumber = currentBookings[indexPath.row]["bookingNumber"] as! Int
            let numOfPeopleWaiting = currentQueueNumber - currentQueueNumInRestaurant
            currentBookingCell.numberOfPeopleWaitingLabel.text = "\(numOfPeopleWaiting) people waiting"
            currentBookingCell.timeLeftLabel.text = "\(numOfPeopleWaiting * 5) mins "
            return currentBookingCell
        // configure cells for history bookings
        } else {
            let historyBookingCell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! BookingTableViewCell
            historyBookingCell.restaurantImage.image = UIImage (named: historyBookings[indexPath.row]["image"] as! String)
            historyBookingCell.bookingNumberLabel.text = "# \(historyBookings[indexPath.row]["bookingNumber"]!)"
            historyBookingCell.restaurantNameLabel.text = (historyBookings[indexPath.row]["resName"] as! String)
            historyBookingCell.timeLeftLabel.text = "Completed"
            return historyBookingCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedSegment == 1 {
            let myIndex = indexPath.row
            restId = currentBookings[myIndex]["resid"] as! Int
            queueId = currentBookings[myIndex]["queueid"] as! Int
            performSegue(withIdentifier: "BookingToMenu", sender: self)
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuView = segue.destination as! MenuViewController
        menuView.restID = restId
        menuView.queueId = queueId
    }
}
