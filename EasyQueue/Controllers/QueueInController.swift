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

    
    let db = EasyQueueDB()
    var restaurantName = "Restaurant"
    var restId = 0
    var custAmount = 0
    var userId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restNameLabel.text = restaurantName
        let _ = db.getRestaurant(id: restId)
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
        let _ = db.setQueue(uid: 1, rid: restId, num: custAmount, stat: 1)
        let _ = db.setQueueSystem(rid: restId)
//        performSegue(withIdentifier: "QueueSummary", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let queueDetail = segue.destination as! QueueSummaryController
        queueDetail.restaurantName = restaurantName
        queueDetail.restId = restId
        queueDetail.custAmount = Int(customerAmount.text!)!
        queueDetail.userId = 1
    }
 
    
}
