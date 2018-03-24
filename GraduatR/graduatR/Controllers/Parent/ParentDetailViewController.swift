//
//  ParentDetailViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 2/15/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class ParentDetailViewController: UIViewController {
    
    
    @IBOutlet weak var keyField: UITextField!
    var name = AllVariables.Fname
    var lastName = AllVariables.Lname
    var user = AllVariables.Username
    var ref: DatabaseReference!
    
    @IBOutlet weak var welcomeText: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        welcomeText.text = name
        
        ref = Database.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedProceed(_ sender: Any) {
        
        
    }
    

}
