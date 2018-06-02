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

    @IBOutlet weak var seatIntfoLabel: UILabel!
    
    let db = EasyQueueDB()
    var restaurantName = "Restaurant"
    var restId = 0
    var custAmount = 0
    var userId = 0
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restNameLabel.text = restaurantName
        let _ = db.getRestaurant(id: restId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    Queue In button
    @IBAction func queueButton(_ sender: UIButton) {
        
// seat number validation
        if (customerAmount.text != ""){
             custAmount = Int(customerAmount.text!)!
            if (custAmount <= 0){
                seatIntfoLabel.text = "Seat number must be more than 0"
            }else{
                number = (db.getQueueSystem(rid: restId)["total"] as! Int) + 1
                let _ = db.setQueue(uid: UserId, rid: restId, num: number, amount: custAmount, stat: 1)
                let _ = db.setQueueSystem(rid: restId)
                performSegue(withIdentifier: "QueueSummary", sender: sender)
            }
        }else{
            seatIntfoLabel.text = "Seat number is required"
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let queueDetail = segue.destination as! QueueSummaryController
        queueDetail.restaurantName = restaurantName
        queueDetail.restId = restId
        queueDetail.custAmount = Int(customerAmount.text!)!
        queueDetail.userId = UserId
        queueDetail.queueId = db.getQueue(uid: UserId, rid: restId, num: number, amount: custAmount, stat: 1)
    }
    
 
    
}
