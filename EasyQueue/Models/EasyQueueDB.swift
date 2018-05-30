//
//  EasyQueueDB.swift
//  EasyQueue
//
//  Created by Nicholas on 16/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class EasyQueueDB {
    let db = SQLiteBase()
    let path = Bundle.main.path(forResource: "EasyQueueDB", ofType: "sqlite3")!
    
    // open db
    func open() {
        _ = db.open(dbPath: path)
    }
    
    // reload db script for development
    func makeDB() {
        purgeDB()
        makeTable()
        insertData()
    }
    
    func purgeDB() {
        self.open()
        let drops = db.query(sql: "select 'drop table ' || name || ';' as dropsql from sqlite_master where type = 'table';")
        for drop in drops {
            _ = db.execute(sql: drop["dropsql"] as! String)
        }
        db.closeDB()
    }
    
    func makeTable() {
        self.open()
        _ = db.execute(sql: "CREATE TABLE `users` ( `id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` TEXT NOT NULL, `password` TEXT NOT NULL, `fullname` TEXT NOT NULL );")
        _ = db.execute(sql: "CREATE TABLE `restaurants` ( `id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `image` TEXT NOT NULL );")
        _ = db.execute(sql: "CREATE TABLE `dishes` ( `id` INTEGER PRIMARY KEY AUTOINCREMENT, `restid` INTEGER NOT NULL, `name` TEXT NOT NULL );")
        _ = db.execute(sql: "CREATE TABLE `queues` ( `id` INTEGER PRIMARY KEY AUTOINCREMENT, `userid` INTEGER NOT NULL, `restid` INTEGER NOT NULL, `number` INTEGER NOT NULL, `status` INTEGER NOT NULL DEFAULT 0 );")
        _ = db.execute(sql: "CREATE TABLE `queuesystem` ( `restid` INTEGER NOT NULL, `current` INTEGER NOT NULL, `total` INTEGER NOT NULL );")
        _ = db.execute(sql: "CREATE TABLE `orders` ( `queueid` INTEGER NOT NULL, `dishid` INTEGER NOT NULL, `quantity` INTEGER NOT NULL );")
        db.closeDB()
    }
    
    func insertData() {
        self.open()
        
        // insert into users table
        _ = db.execute(sql: "INSERT INTO `users` VALUES (1,'user1','user1','user 1 name');")
        _ = db.execute(sql: "INSERT INTO `users` VALUES (2,'user2','user2','user 2 name');")

        // insert into restaurants table
        _ = db.execute(sql: "INSERT INTO `restaurants` VALUES (1,'Menya mappen','rest1.jpg');")
        _ = db.execute(sql: "INSERT INTO `restaurants` VALUES (2,'Chinese noodle','rest2.jpg');")
        _ = db.execute(sql: "INSERT INTO `restaurants` VALUES (3,'Hey kebab','rest3.jpg');")
        _ = db.execute(sql: "INSERT INTO `restaurants` VALUES (4,'Dodee Paidang','rest4.jpg');")
        _ = db.execute(sql: "INSERT INTO `restaurants` VALUES (5,'test','rest2.jpg');")
       
        //insert into order table
        _ = db.execute(sql: "INSERT INTO `orders` VALUES (11,12,1);")
        _ = db.execute(sql: "INSERT INTO `orders` VALUES (12,12,1);")
        _ = db.execute(sql: "INSERT INTO `orders` VALUES (13,13,1);")
        
        //insert into queue table
        _ = db.execute(sql: "INSERT INTO `queues` VALUES (11,1,3,7,0);")
        _ = db.execute(sql: "INSERT INTO `queues` VALUES (12,2,4,8,0);")
        _ = db.execute(sql: "INSERT INTO `queues` VALUES (13,2,5,9,2);")

        // insert into queuesystem table
        _ = db.execute(sql: "INSERT INTO `queuesystem` VALUES (1,0,0);")
        _ = db.execute(sql: "INSERT INTO `queuesystem` VALUES (2,0,0);")
        _ = db.execute(sql: "INSERT INTO `queuesystem` VALUES (3,0,0);")
        _ = db.execute(sql: "INSERT INTO `queuesystem` VALUES (4,0,0);")
        _ = db.execute(sql: "INSERT INTO `queuesystem` VALUES (5,0,0);")

        // insert dishes
        _ = db.execute(sql: "INSERT INTO `dishes` VALUES (1,1,'Honey Chicken');")
        _ = db.execute(sql: "INSERT INTO `dishes` VALUES (2,2,'Beef Noodle');")
        _ = db.execute(sql: "INSERT INTO `dishes` VALUES (3,3,'Hawaii Pizza');")
        _ = db.execute(sql: "INSERT INTO `dishes` VALUES (4,4,'Watermelon Cake');")
        _ = db.execute(sql: "INSERT INTO `dishes` VALUES (5,1,'Chicken Nuggets');")
        _ = db.execute(sql: "INSERT INTO `dishes` VALUES (6,1,'French Fries');")
        _ = db.execute(sql: "INSERT INTO `dishes` VALUES (7,1,'Coke');")
        
        db.closeDB()
    }
    
    // get all restaurants
    func getRestaurant() -> [[String : Any]] {
        self.open()
        let data = db.query(sql: "SELECT * FROM restaurants;")
        db.closeDB()
        
        return data
    }
    
    // get restaurant by id
    func getRestaurant(id: Int) -> [String : Any] {
        self.open()
        let data = db.query(sql: "SELECT * FROM restaurants WHERE id = '\(id)';")
        db.closeDB()
        
        return data[0]
    }
    
    func  getDishesByRestaurantId(id : Int) -> [[String : Any]] {
        self.open()
        let data = db.query(sql: "SELECT * FROM dishes WHERE restid = '\(id)';")   //
        db.closeDB()
        
        return data
    }
    
    // get all bookings from database by using queueStatus as a filter
    func getBookings(status:Int) -> [[String:Any]] {
        let query = """
        SELECT res.name as resName,que.number,que.status,dish.name as menuName, res.image
        FROM ((orders ord
        inner join queues que on ord.queueid=que.id)
        inner join restaurants res on que.restid=res.id)
        inner join dishes dish on ord.dishid=dish.id
        WHERE que.status = \(status);
        """
        self.open()
        let data = db.query(sql: query)
        db.closeDB()
        return data
    }
    
    //get user details by username and password
    func getUserByUsernameAndPassword(username:String, password: String) -> [[String:Any]] {
        let query = "SELECT * FROM users WHERE username = '\(username)' and password = '\(password)';"
        self.open()
        let user = db.query(sql: query)
        db.closeDB()
        return user
    }

//    set queue
    func setQueue(uid: Int, rid: Int, num: Int, stat: Int) {
        self.open()
        // insert into queue table
        _ = db.execute(sql: "INSERT INTO `queues` ('userid', 'restid', 'number', 'status') VALUES ('\(uid)','\(rid)','\(num)','\(stat)');")
        db.closeDB()
    }

//    get queue
    func getQueue(userid: Int) -> [String : Any] {
        self.open()
        let data = db.query(sql: "SELECT * FROM queues WHERE userid = '\(userid)';")
        db.closeDB()
        return data[0]
    }

    // get restaurant by name
    func getRestaurant(name: String) -> [[String : Any]] {
        self.open()
        let data = db.query(sql: "SELECT * FROM restaurants WHERE name LIKE '%\(name)%';")
        db.closeDB()
        
        return data
    }

// set queue system
    func setQueueSystem(rid: Int) {
        self.open()
        // update into queuesystem table
        _ = db.execute(sql: "UPDATE queuesystem SET total = total + 1 WHERE restid = '\(rid)';")
        db.closeDB()
    }
    
// get queue system
    func getQueueSystem(rid: Int) -> [String : Any] {
        self.open()
        let data = db.query(sql: "SELECT current,total FROM queuesystem WHERE restid = '\(rid)';")
        db.closeDB()
        return data[0]
    }
}
