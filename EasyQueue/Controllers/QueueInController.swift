//
//  QueueInController.swift
//  EasyQueue
//
//  Created by Kunanon Pititheerachot on 20/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class QueueInController: UIViewController {
    
    @IBOutlet weak var restNameLabel: UILabel!
    @IBOutlet weak var customerAmount: UITextField!

    
    let testDB = EasyQueueDB()
    var restaurantName = "Restaurant"
    var restaurantID = 0
    var custAmount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restNameLabel.text = restaurantName
        restaurantID = testDB.getRestaurantID(restaurantName: restaurantName)
//        customerAmount.text = String(restaurantID)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        if identifier == "theIdentifier" {
//            custAmount = Int(customerAmount.text!)!
//            testDB.setQueue(uid: 1, rid: restaurantID, num: custAmount, stat: 1)
//
//        }
//        return true
//    }
    
    @IBAction func queueButton(_ sender: UIButton) {
        custAmount = Int(customerAmount.text!)!
        let result = testDB.setQueue(uid: 1, rid: restaurantID, num: custAmount, stat: 1)
        performSegue(withIdentifier: "QueueSummary", sender: sender)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        if segue.identifier == "yourIdentifier" {
//
//        }
//    }
    
}
