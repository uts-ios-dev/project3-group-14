//
//  QueueSummaryController.swift
//  EasyQueue
//
//  Created by Kunanon Pititheerachot on 21/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit


class QueueSummaryController: UIViewController {

    
    let db = EasyQueueDB()
    var data: [[String : Any]] = [[:]]
    var restaurantName = "Restaurant"
    var restaurantID = 0
    var restId = 0
    var custAmount = 0
    var userId = 0
    

    
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var customerAmount: UILabel!
    @IBOutlet weak var currentQueue: UILabel!
    @IBOutlet weak var totalQueue: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        let queueTimestamp = "\(hour):\(minute):\(second)\n\(day)/\(month)/\(year)"

        let restQueue = db.getQueueSystem(rid: restId)
        
        restaurantNameLabel.text = restaurantName
        customerAmount.text = String(custAmount)
        currentQueue.text = (restQueue["current"] as! String)
        totalQueue.text = (restQueue["total"] as! String)
        timestamp.text = queueTimestamp
        
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
