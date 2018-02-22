//
//  AddCourseViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 2/22/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class AddCourseViewController: UIViewController {

    @IBOutlet weak var courseName: UILabel!
    var n = String()
    var name = String()
    var lastName = String()
    var GPA = String()
    var user = String()
    var Class = String()
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        courseName.text = n
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func pressedAddButton(_ sender: Any) {
        
        ref.child("Users").child("Student").child(user).setValue(["Fname": name, "Lname": lastName, "GPA" : GPA, "Class": Class, "Course": n])
        
        let alert = UIAlertController(title: "YAY!", message: "Course added to your profile!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print ("ok tappped")
        }
        alert.addAction(OKAction)
        self.present(alert, animated: true) {
            print("ERROR")
        }

        
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
