//
//  ParentCDetailViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/24/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class ParentCDetailViewController: UIViewController {
    
    
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var info: UILabel!
    var n = String()
    var name = AllVariables.Fname
    var lastName = AllVariables.Lname
    var GPA = AllVariables.GPA
    var user = AllVariables.Username
    var Class = AllVariables.standing
    var ref: DatabaseReference!
    var c = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
  
        
        courseName.text = n
        info.text = c
        ref = Database.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    
    
    @IBAction func reviewbutton(_ sender: Any) {
        
        AllVariables.courseselected = n
        AllVariables.courseselected = AllVariables.courseselected.replacingOccurrences(of: "\t", with: " ")
        
    }
}
