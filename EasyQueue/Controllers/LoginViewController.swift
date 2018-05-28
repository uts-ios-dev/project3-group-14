//
//  ViewController.swift
//  EasyQueue
//
//  Created by Nicholas on 10/5/18.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var user : [[String:Any]] = []
    let db = EasyQueueDB()
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        db.makeDB()
    }

    //check username and password, if match the record in database, jump to next scene
    @IBAction func loginTapped(_ sender: UIButton) {
            let username = usernameTextField.text
            let password = passwordTextField.text
            user = db.getUserByUsernameAndPassword(username: username!, password: password!)
        
        if user.count == 1 {
            print ("match, jump next")
            //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

