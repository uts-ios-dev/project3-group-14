//
//  RestaurantListTableViewCell.swift
//  EasyQueue
//
//  Created by Nicholas on 20/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class RestaurantListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var RestaurantImageView: UIImageView!
    @IBOutlet weak var RestaurantNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
