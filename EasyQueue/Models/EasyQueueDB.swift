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
    func getRestaurantID(restaurantName: String) -> Int {
        _ = db.open()
        let data = db.query(sql: "SELECT id FROM restaurants WHERE name = '\(restaurantName)' ")
        db.closeDB()
        return data[0]["id"] as! Int
    }
//   set queue function
    func setQueue(uid: Int, rid: Int, num: Int,  stat: Int) -> Int {
        _ = db.open()
        let data = db.execute(sql: "INSERT INTO queues (userid, restid, number, status) VALUES ('\(uid)', '\(rid)', '\(num)', '\(stat)')")
        db.closeDB()
        return data
    }
//    get queue function
    func getQueue(rid: Int) -> [[String: Any]]{
        _ = db.open()
        let data = db.query(sql: "SELECT id, userid, restid, number, status FROM queues WHERE userid ='\(rid)' ")
        db.closeDB()
        return data
    }
}

