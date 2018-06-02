//
//  MenuViewController.swift
//  EasyQueue
//
//  Created by 林泽媛 on 22/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    let db = EasyQueueDB()
    var data: [[String : Any]] = [[:]]
    var orderList: [[String : Any]] = [[:]]
    var checkFlag  = [Bool]()
    var runCheck = true
    var restID =  0     // passed from the previous page
    var queueId = 0     // passed from the previous page
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //UserDefaults.standard.set(nil, forKey: "Orders")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        data = db.getDishesByRestaurantId(id: restID)
        orderList = db.getOrder(queueId: queueId)
        
        for _ in 0..<data.count
        {
                checkFlag.append(false)
        }
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   // devide the the menu table into 2 sections.
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if(section == 0){
            return "      Menus"
        }else{
            return "      Order"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0 ){
            return data.count;
        }else{
            return 1;
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "menuIdentifier", for: indexPath)
            
            cell.textLabel!.text = (data[indexPath.row]["name"] as! String)
            
            if(checkFlag[indexPath.row]){
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
            
            if orderList.count > 0 && runCheck == true{
                for i in 0..<orderList.count {
                    if (orderList[i]["dishid"] as! Int) == (data[indexPath.row]["id"] as! Int) {
                        cell.accessoryType = .checkmark
                    }
                }
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "toOrderView", for: indexPath)
            cell.textLabel!.text = "Order"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        runCheck = false
        if(indexPath.section == 0){
            checkFlag[indexPath.row] = !checkFlag[indexPath.row]
            tableView.reloadData()
        }else{
            var orders = [[String : Any]]()
            for index in 0..<data.count{
                if(checkFlag[index]){
                    orders.append(data[index])
                }
            }
            
            db.delOrder(queueId: queueId) // delete the orders first
            for i in 0..<orders.count {
                // add the orders
                db.setOrder(queueId: queueId, dishId: orders[i]["id"] as! Int)
            }
            
            self.performSegue(withIdentifier: "showDetail", sender: nil)
        }
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let dest = segue.destination as? OrderViewController {
            dest.queueId = queueId
        }
    }
    

}
