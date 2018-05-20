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
//    get restaurant ID by name function
    func getRestaurantID(restaurantName: String) -> [[String: Any]] {
        _ = db.open()
        let data = db.query(sql: "SELECT id FROM restaurants WHERE name = 'restaurantName' ")
        db.closeDB()
        return data
    }
//   set queue function
    func setQueue(uid: Int, rid: Int, num: Int,  stat: Int) -> [[String: Any]] {
        _ = db.open()
        let data = db.query(sql: "INSERT INTO queues (userid, restid, number, status) VALUES ('uid', 'rid', 'num', 'stat')")
        db.closeDB()
        return data
    }
//    get queue function
    func getQueue(rid: Int) -> [[String: Any]]{
        _ = db.open()
        let data = db.query(sql: "SELECT id, userid, restid, number, status FROM queues WHERE userid ='uid' ")
        db.closeDB()
        return data
    }
}

