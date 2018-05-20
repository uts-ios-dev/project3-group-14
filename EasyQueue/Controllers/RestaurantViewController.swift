//
//  RestaurantViewController.swift
//  EasyQueue
//
//  Created by Nicholas on 20/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    @IBOutlet weak var RestaurantNameLabel: UILabel!
    @IBOutlet weak var RestaurantImageView: UIImageView!
    
    let db = EasyQueueDB()
    var restId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        populateDetail()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateDetail() {
        let rest = db.getRestaurant(id: restId)
        RestaurantNameLabel.text = (rest["name"] as! String)
        RestaurantNameLabel.sizeToFit()
        RestaurantImageView.image = UIImage(named: rest["image"] as! String)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
