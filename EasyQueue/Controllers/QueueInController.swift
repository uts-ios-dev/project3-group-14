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
    @IBOutlet weak var queueButton: UIButton!
    
    let testDB = EasyQueueDB()
    var restaurantName = "Restaurant"
    var restaurantID = 0
    var custAmount = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restNameLabel.text = restaurantName
        restaurantID = testDB.getRestaurantID(restaurantName: restaurantName)
        custAmount = customerAmount.text!

        
//        customerAmount.text = String(restaurantID)
//        if testDB.setQueue(uid: <#T##Int#>, rid: <#T##Int#>, num: <#T##Int#>, stat: ) == 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        if segue.identifier == "yourIdentifier" {
//
//        }
//    }
    
}
