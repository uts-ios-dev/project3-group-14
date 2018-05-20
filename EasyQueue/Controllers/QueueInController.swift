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
    var restaurantID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restNameLabel.text = restaurantName
//        restaurantID = testDB.getRestaurantID(restaurantName: restaurantName)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
