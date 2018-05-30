//
//  ViewController.swift
//  EasyQueue
//
//  Created by Nicholas on 10/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
         let db = EasyQueueDB()
        //db.makeDB()
       
        
        
       
        print(db.getRestaurant(id : 1))
        print(db.getMenuByRestaurantId(id: 1))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

