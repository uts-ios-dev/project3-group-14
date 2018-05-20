//
//  EasyQueueDB.swift
//  EasyQueue
//
//  Created by Nicholas on 16/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class EasyQueueDB {
    let db = SQLiteDB.shared
    
    func getRestaurant() -> [[String : Any]] {
        _ = db.open()
        let data = db.query(sql: "SELECT * FROM restaurants")
        db.closeDB()
        return data
    }
    
}

