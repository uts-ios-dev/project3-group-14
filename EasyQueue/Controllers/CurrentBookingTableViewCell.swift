//
//  CurrentBookingTableViewCell.swift
//  EasyQueue
//
//  Created by Ling Chen on 2/6/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class CurrentBookingTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var bookingNumberLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var numberOfPeopleWaitingLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
