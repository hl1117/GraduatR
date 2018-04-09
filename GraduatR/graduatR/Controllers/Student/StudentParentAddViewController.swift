//
//  StudentParentAddViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/24/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class StudentParentAddViewController: UIViewController {
    
    
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var myUIDlabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myUIDlabel.text = AllVariables.uid
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
